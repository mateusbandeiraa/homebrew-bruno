cask "bruno-source" do
  version "4.2.0"
  sha256 "e5f10bf92bd00967ea14ae316b88242af4b9bcfcb8f2470da9593f789c371fa7"

  url "https://github.com/mateusbandeiraa/homebrew-bruno/releases/download/v#{version}/Bruno-#{version}-arm64.zip",
      verified: "github.com/mateusbandeiraa/homebrew-bruno/"
  name "Bruno (source build)"
  desc "API client, built from MIT-licensed source"
  homepage "https://github.com/mateusbandeiraa/homebrew-bruno"

  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  conflicts_with cask: "bruno"

  app "Bruno.app"

  # The app is ad-hoc signed rather than signed with a Developer ID, so a
  # quarantined copy is refused by Gatekeeper. Install with --no-quarantine.
  caveats <<~EOS
    This is an unofficial build compiled from Bruno's MIT-licensed source.
    It is not affiliated with or endorsed by the Bruno project, and it does
    not include any feature of Bruno's commercial editions.

    It is ad-hoc signed, so it must be installed without quarantine:
      brew install --cask --no-quarantine bruno-source
  EOS

  zap trash: [
    "~/Library/Application Support/bruno",
    "~/Library/Preferences/com.usebruno.app.plist",
    "~/Library/Saved Application State/com.usebruno.app.savedState",
  ]
end
