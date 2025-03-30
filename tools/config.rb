wiki_options = {
  critic_markup: true,
  emoji: true,
  page_file_dir: 'pages',
  index_page: 'home',
}

# Load wiki options into the proper space
Precious::App.set(:wiki_options, wiki_options)
