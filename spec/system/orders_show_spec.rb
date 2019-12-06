require "rails_helper"

RSpec.describe "order show page", type: SYSTEM_TEST do
  it "displays line item information" do
    line_item = create(:line_item)

    visit admin_order_path(line_item.order)

    expect(page).to have_content(line_item.unit_price)
    expect(page).to have_content(line_item.quantity)
    expect(page).to have_content(line_item.total_price)
  end

  it "links to line items", :js do
    line_item = create(:line_item)

    visit admin_order_path(line_item.order)
    click_row_for(line_item)

    expect(page).to have_header(displayed(line_item))
  end

  it "user cannot click through to payment edit page" do
    payment = create(:payment)

    visit admin_order_path(payment.order)

    within("table") do
      expect(page).not_to have_link t("administrate.actions.edit")
    end
  end

  it "user cannot click through to payment delete record" do
    payment = create(:payment)

    visit admin_order_path(payment.order)

    within("table") do
      expect(page).not_to have_link t("administrate.actions.destroy")
    end
  end
end
