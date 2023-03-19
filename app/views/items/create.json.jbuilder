if @item.persisted?
  # item @ list tab
  json.inserted_item render(partial: "items/item", formats: :html, locals: { item: @item })
  # item @ usual items tab
  json.inserted_usual_item render(partial: "items/usual_item", formats: :html, locals: { item: @item })
  # new item form @ list tab
  json.form_new_item render(partial: "items/new_item", formats: :html, locals: { list: @list, item: Item.new })
else
  json.form_failed_item render(partial: "items/new_item", formats: :html, locals: { list: @list, item: @item })
end
