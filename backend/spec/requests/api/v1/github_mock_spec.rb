require_relative './../example'

describe GithubApiClient do
  describe 'users' do
    let(:github_response) { GithubApiClient.users }
    it "returns correctly github users" do
      expect(github_response).to be_kind_of(Hash)
      expect(github_response).to have_key(:data)
      expect(github_response).to have_key(:status)
    end
  end
end
