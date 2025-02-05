cask "hookmark" do
  version "5.1,2023.04"
  sha256 "54aba205cf27ef46d999719d2e7b17b6196aaeb8fb03bcb130e323dccdb1db88"

  url "https://hookproductivity.com/wp-content/uploads/#{version.csv.second.major}/#{version.csv.second.minor}/Hookmark-app-#{version.csv.first}.dmg_.zip",
      user_agent: :fake
  name "Hook"
  desc "Link and retrieve key information"
  homepage "https://hookproductivity.com/"

  livecheck do
    url "https://hookproductivity.com/download"
    regex(%r{href=.*?/(\d+)/(\d+)/Hookmark[._-]app[._-](\d+(?:\.\d+)*)(?:[._-]b(\d+(?:\.\d+)*))?\.dmg}i)
    strategy :page_match do |page, regex|
      match = page.match(regex)
      next if match.blank?

      if match[4].present?
        "#{match[3]},#{match[4]},#{match[1]}.#{match[2]}"
      else
        "#{match[3]},#{match[1]}.#{match[2]}"
      end
    end
  end

  auto_updates true
  depends_on macos: ">= :el_capitan"

  app "Hookmark.app"

  uninstall launchctl: "com.cogsciapps.hookautolaunchhelper",
            quit:      "com.cogsciapps.hook"

  zap trash: [
    "~/Library/Application Support/com.cogsciapps.hook",
    "~/Library/Caches/com.cogsciapps.hook",
    "~/Library/HTTPStorages/com.cogsciapps.hook",
    "~/Library/Logs/com.cogsciapps.hook",
    "~/Library/Preferences/com.cogsciapps.hook.plist",
    "~/Library/WebKit/com.cogsciapps.hook",
  ]
end
