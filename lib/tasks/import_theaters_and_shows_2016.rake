task :import_theaters_and_shows_2016 => :environment do
  theaters_and_shows = {
    "Bellevue Little Theatre" => [
      "Best Little Whorehouse in Texas",
      "To Kill A Mockingbird",
      "Best of Friends",
      "Nunsense A-Men",
      "Red, White, and Tuna"
    ],
    "Blue Barn Theatre" => [
      "The Grown-Up",
      "Little Nelly's Naughty Noel",
      "Frost/Nixon",
      "The Christians",
      "Heathers The Musical"
    ],
    "Brigit Saint Brigit" => [
      "Arms and the Man",
      "Sive",
      "Tyger's Hart",
      "Lincoln's Shakespeare"
    ],
    "Chanticleer Theatre" => [
      "Guys and Dolls Jr. ",
      "Dracula",
      "Picnic",
      "Sweeney Todd",
      "Mary Poppins"
    ],
    "Circle Theater" => [
      "Yankee Tavern",
      "The Designated Mourner"
    ],
    "Creighton University Theatre" => [
      "Stage of the Arts (4 original One Acts)",
      "Sunday in the Park with George",
      "Tom Jones",
      "Antigone"
    ],
    "Florentine Players" => [
      "Engaged",
      "Errorplane!"
    ],
    "Iowa Western CC Theatre" => [
      "Boom",
      "The Awesome 80's Prom"
    ],
    "Kountze Theatre/KBC Prod." => [
      "Jacob Marley's Christmas Carol",
      "The Housekeeper",
      "The Queen of Bingo"
    ],
    "Lofte Community Theatre" => [
      "Proof",
      "Nana's Naughty Knickers",
      "Dear Santa",
      "The Christmas Spirit",
      "Leading Ladies"
    ],
    "Mills Masquers Comm. Theatre" => [
      "Happy Days!",
      "The Laramie Project",
      "Miracle on 34th Street",
      "Oliver!",
      "A Midsummer Night's Dream"
    ],
    "Nebraska Shakespeare" => [
      "As You Like It",
      "Othello"
    ],
    "Omaha Community Playhouse" => [
      "Beertown",
      "Calendar Girls",
      "Caroline, or Change",
      "City of Angels",
      "Lost Boy Found in Whole Foods",
      "Love, Loss And What I Wore",
      "Man of La Mancha",
      "Mauritius",
      "The Producers"
    ],
    "Papillion LaVista Comm. Thea." => [
      "The Wizard of Oz"
    ],
    "Ralston Community Theatre" => [
      "Thoroughly Modern Millie"
    ],
    "The Rose Theatre" => [
      "Pete the Cat",
      "Ivy + Bean",
      "Palette of Possibility",
      "Sherlock Holmes &amp; the 1st Baker Street Irregular",
      "Peter and the Star Catcher",
      "The Lightening Thief",
      "A Child's Garden of Verses",
      "Plastic Drastic",
      "Honk!",
      "Elephant &amp; Piggie's We Are in Play",
      "Disney's The Little Mermaid"
    ],
    "The Shelterbelt Theatre" => [
      "Thank You For Being a Friend",
      "The Singularity",
      "Untitled Series #7",
      "The Feast"
    ],
    "Southwest Iowa Theatre Group" => [
      "A Little Princess, the Musical",
      "Dial "M" for Murder",
      "The Dixie Swim Club"
    ],
    "SNAP! Productions" => [
      "In The Bones",
      "Mama's Girls",
      "Cock",
      "7 Homeless Mammoths Wander New England"
    ],
    "University of Nebraska Theatre" => [
      "Dracula",
      "Animal Farm",
      "The 3 Penny Opera",
      "Cloud9",
      "KWAIDAN"
    ],
    "Wilson Performing Arts Center" => [
      "Bye, Bye Birdie",
      "Nunsense II",
      "Never Too Late",
      "Steel Magnolias",
      "You're A Good Man, Charlie Brown"
    ]
  }

  theaters_and_shows.each do |theater, shows|
    puts "Creating #{theater}."
    theater = Theater.create!(name: theater)
    theater.plays.create!(shows.map { |s| {title: s} })
  end
end
