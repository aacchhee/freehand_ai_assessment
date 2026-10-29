-- Collapsed source panels after each exercise (the Quarto source of every
-- math-exercise block and AI-feedback activity, with referenced test files),
-- so teachers see the options such as harder/simpler. Adapted from
-- Erasmus-CTM/math-exercise _filters/example-source.lua (AGPL-3.0-or-later),
-- without its per-exercise policy panel. Runs before the exercise filters, on
-- pages that set `example-source: true`.
local enabled = false
local summary, jsxSummary = 'Show Quarto exercise source', 'Show JSXGraph code'
local function escape(text)
  return text:gsub('&','&amp;'):gsub('<','&lt;'):gsub('>','&gt;'):gsub('"','&quot;')
end
local function panel(source, title, testsPanel, jsx)
  local pieces = {'<div class="example-author-notes ai-feedback-ignore"><details class="math-example-source" data-source-kind="'..(jsx and 'jsxgraph' or 'exercise')..'"><summary>'..title..'</summary><pre><code class="language-markdown">'..escape(source)..'</code></pre>'}
  if testsPanel then table.insert(pieces, testsPanel) end
  table.insert(pieces, '</details></div>')
  return pandoc.RawBlock('html',table.concat(pieces,'\n'))
end
local function meta(m)
  enabled = m['example-source'] == true
  local lang=pandoc.utils.stringify(m.lang or 'en'):lower():match('^(%a+)')
  if lang=='nb' or lang=='no' then summary,jsxSummary='Vis Quarto-kildekode for oppgaven','Vis JSXGraph-kode'
  else summary,jsxSummary='Show Quarto exercise source','Show JSXGraph code' end
end
local function code(el)
  if not enabled or not quarto.doc.is_format('html') then return end
  local opening
  for _, name in ipairs({'math-exercise','py-exercise','pyodide-python'}) do
    if el.classes:includes('{'..name..'}') or el.classes:includes(name) then opening='{'..name..'}' end
  end
  local jsx=el.classes:includes('jsxgraph')
  if jsx then
    local args={'.jsxgraph'}
    for _,class in ipairs(el.classes) do if class~='jsxgraph' then table.insert(args,'.'..class) end end
    if el.identifier~='' then table.insert(args,'#'..el.identifier) end
    for key,value in pairs(el.attributes) do table.insert(args,key..'="'..tostring(value):gsub('"','\\"')..'"') end
    opening='{'..table.concat(args,' ')..'}'
  end
  if not opening then return end
  local testsPanel
  local tests=el.text:match('#|%s*tests:%s*([^\r\n]+)')
  if opening=='{math-exercise}' and tests and tests:match('%.py$') then
    local base=quarto.project.directory or pandoc.path.directory(quarto.doc.input_file)
    local f=assert(io.open(pandoc.path.join({base,tests}),'r'),'Cannot read author tests: '..tests)
    local contents=f:read('*a');f:close()
    testsPanel='<details class="math-example-tests"><summary>Author tests: '..escape(tests)..'</summary><pre><code class="language-python">'..escape(contents)..'</code></pre></details>'
  end
  return {el,panel('```'..opening..'\n'..el.text..'\n```',jsx and jsxSummary or summary,testsPanel,jsx)}
end
local function div(el)
  if not enabled or not quarto.doc.is_format('html') or not el.classes:includes('ai-feedback') then return end
  local source=pandoc.write(pandoc.Pandoc({el}),'markdown',{wrap_text='none'})
  return {el,panel(source,summary)}
end
return {{Meta=meta},{CodeBlock=code,Div=div}}
