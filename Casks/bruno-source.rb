cask "bruno-source" do
  version "4.2.0"
  sha256 "e5f10bf92bd00967ea14ae316b88242af4b9bcfcb8f2470da9593f789c371fa7"

  url "https://github.com/mateusbandeiraa/homebrew-bruno/releases/download/v#{version}/Bruno-#{version}-arm64.zip"
  name "Bruno (source build)"
  desc "API client, built from MIT-licensed source"
  homepage "https://github.com/mateusbandeiraa/homebrew-bruno"

  conflicts_with cask: "bruno"
  depends_on arch: :arm64
  depends_on :macos

  app "Bruno.app"

  # The app is ad-hoc signed rather than signed with a Developer ID, so
  # Gatekeeper refuses a quarantined copy. Homebrew always quarantines cask
  # artifacts, so clear the attribute here instead; this runs on upgrades as
  # well as the first install.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Bruno.app"]
  end

  zap trash: [
    "~/Library/Application Support/bruno",
    "~/Library/Preferences/com.usebruno.app.plist",
    "~/Library/Saved Application State/com.usebruno.app.savedState",
  ]

  caveats <<~EOS
    This is an unofficial build compiled from Bruno's MIT-licensed source.
    It is not affiliated with or endorsed by the Bruno project, and it does
    not include any feature of Bruno's commercial editions.

    The app is ad-hoc signed; the cask clears its quarantine attribute on
    install and upgrade so Gatekeeper allows it to launch.
  EOS
end
