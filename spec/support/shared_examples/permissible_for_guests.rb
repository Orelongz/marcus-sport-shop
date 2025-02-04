RSpec.shared_examples "permissible for guests" do
  context "for a guest" do
    let(:user) { nil }

    it { should permit(:show) }
    it { should permit(:index) }

    it { should_not permit(:create) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context "for a user" do
    let(:user) { create(:user) }

    it { should permit(:show) }
    it { should permit(:index) }

    it { should_not permit(:create) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context "for an admin user" do
    let(:user) { create(:admin_user) }

    it { should permit(:show) }
    it { should permit(:index) }
    it { should permit(:create) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end
end
