-- Reformat all heading text 
function Header(el)
  el.content = pandoc.Emph(el.content)
  return el
end

-- function Div(el)
--   quarto.log.output(el.classes)
--   if el.classes:contains("csl-entry") then
--     quarto.log.output(el)
--   end
-- end

function Link(el)
  --quarto.log.output("Handling Div")
  --quarto.log.output(el.target)
  if string.find(el.target, "dropbox") then
    quarto.log.output(el.target)
    --el.content = pandoc.Str("Hello")
    return pandoc.Link("a", "b")
  else
    return el
  end
end


-- function Link(el)
--   quarto.log.output("Handling link")
--   quarto.log.output(el.content)
--   quarto.log.output(type(el.content))
--   quarto.log.output(#el.content)
--   quarto.log.output("Inlines:")
--   quarto.log.output(el.content['Inlines'])
--   quarto.log.output(el.content.getn())
--   --quarto.log.output("-----")
-- end
