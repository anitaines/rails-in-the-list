# updated item @ list tab
json.updated_item render(partial: "items/item", formats: :html, locals: { item: @item })
# updated item @ usual items tab
json.updated_usual_item render(partial: "items/usual_item", formats: :html, locals: { item: @item })
