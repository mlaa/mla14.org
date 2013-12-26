/* Menu data */

MLA14.module('Data.Menu', function(Menu) {

  // Section-level menus
  Menu.Data = {
    program: [
      {
        id: 'program/th',
        title: 'Thursday, 9 January'
      },
      {
        id: 'program/fr',
        title: 'Friday, 10 January'
      },
      {
        id: 'program/sa',
        title: 'Saturday, 11 January'
      },
      {
        id: 'program/su',
        title: 'Sunday, 12 January'
      },
      {
        id: 'filter',
        title: 'Filter by category'
      }
    ],
    people: [
      {
        id: 'people/A',
        title: 'A'
      },
      {
        id: 'people/B',
        title: 'B'
      },
      {
        id: 'people/C',
        title: 'C'
      },
      {
        id: 'people/D',
        title: 'D'
      },
      {
        id: 'people/E',
        title: 'E'
      },
      {
        id: 'people/F',
        title: 'F'
      },
      {
        id: 'people/G',
        title: 'G'
      },
      {
        id: 'people/H',
        title: 'H'
      },
      {
        id: 'people/I',
        title: 'I'
      },
      {
        id: 'people/J',
        title: 'J'
      },
      {
        id: 'people/K',
        title: 'K'
      },
      {
        id: 'people/L',
        title: 'L'
      },
      {
        id: 'people/M',
        title: 'M'
      },
      {
        id: 'people/N',
        title: 'N'
      },
      {
        id: 'people/O',
        title: 'O'
      },
      {
        id: 'people/P',
        title: 'P'
      },
      {
        id: 'people/Q',
        title: 'Q'
      },
      {
        id: 'people/R',
        title: 'R'
      },
      {
        id: 'people/S',
        title: 'S'
      },
      {
        id: 'people/T',
        title: 'T'
      },
      {
        id: 'people/U',
        title: 'U'
      },
      {
        id: 'people/V',
        title: 'V'
      },
      {
        id: 'people/W',
        title: 'W'
      },
      {
        id: 'people/X',
        title: 'X'
      },
      {
        id: 'people/Y',
        title: 'Y'
      },
      {
        id: 'people/Z',
        title: 'Z'
      },
    ],
    maps: [
      {
        type: 'menu-head',
        title: 'Area Maps'
      },
      {
        href: 'http://goo.gl/maps/CcKo4',
        title: 'MLA Convention Google Map',
        style: 'external'
      },
      {
        type: 'menu-head',
        title: 'Venue Maps'
      },
      {
        id: 'maps/sheraton',
        title: 'Sheraton Chicago'
      },
      {
        id: 'maps/marriott',
        title: 'Chicago Marriott'
      },
      {
        id: 'maps/fairmont',
        title: 'Fairmont Chicago'
      },
      {
        href: '/img/maps/exhibit-area.png',
        title: 'Exhibit Area'
      }
    ],
    info: [
      {
        type: 'menu-head',
        title: 'General Information'
      },
      {
        id: 'info/locations',
        title: 'Convention Locations'
      },
      {
        id: 'info/daily',
        title: '<em>Convention Daily</em>'
      },
      {
        id: 'info/program',
        title: 'Program Online'
      },
      {
        id: 'info/twitter',
        title: '<em>Twitter</em>'
      },
      {
        id: 'info/wifi',
        title: 'Wi-Fi Access'
      },
      {
        id: 'info/weather',
        title: 'What to Do in a Weather or Other Emergency'
      },
      {
        type: 'menu-head',
        title: 'Policies'
      },
      {
        id: 'info/taping',
        title: 'Audio- and Videotaping at Sessions'
      },
      {
        id: 'info/badges',
        title: 'Badges'
      },
      {
        id: 'info/canceling',
        title: 'Canceling Sessions'
      },
      {
        id: 'info/fragrance',
        title: 'Fragrance'
      },
      {
        id: 'info/guest-sessions',
        title: 'Guest Passes to Sessions'
      },
      {
        id: 'info/guest-exhibit-hall',
        title: 'Guest Passes to the Exhibit Hall'
      },
      {
        id: 'info/id',
        title: 'Identification'
      },
      {
        id: 'info/in-absentia',
        title: 'Reading in Absentia'
      },
      {
        id: 'info/smoking',
        title: 'Smoking'
      },
      {
        type: 'menu-head',
        title: 'MLA Registration and Welcome Centers'
      },
      {
        id: 'info/registration',
        title: 'About the MLA Registration and Welcome Centers'
      },
      {
        id: 'info/chicago',
        title: 'Chicago Information and Restaurant Reservations'
      },
      {
        id: 'info/disabilities',
        title: 'Disabilities, Facilities and Services for Persons with'
      },
      {
        id: 'info/housing',
        title: 'Housing Desk'
      },
      {
        id: 'info/membership',
        title: 'Membership Desks'
      },
      {
        id: 'info/commons',
        title: '<em>MLA Commons</em>'
      },
      {
        id: 'info/print-program',
        title: 'Print Copies of the Program'
      },
      {
        type: 'menu-head',
        title: 'On-Site Resources'
      },
      {
        id: 'info/business-centers',
        title: 'Business Centers'
      },
      {
        id: 'info/child-care',
        title: 'Child Care'
      },
      {
        id: 'info/bill-w',
        title: 'Friends of Bill W.'
      },
      {
        id: 'info/headquarters',
        title: 'Headquarters Offices'
      },
      {
        id: 'info/internet-in-hotels',
        title: 'Internet Access by Hotel Guests'
      },
      {
        id: 'info/lost-and-found',
        title: 'Lost and Found'
      },
      {
        id: 'info/lounges',
        title: 'Lounges'
      },
      {
        id: 'info/press-office',
        title: 'Press Office'
      },
      {
        id: 'info/shuttle-bus',
        title: 'Shuttle Bus Service'
      },
      {
        id: 'info/ready-rooms',
        title: 'Speaker Ready Rooms'
      },
      {
        id: 'info/transportation',
        title: 'Transportation in Chicago'
      },
      {
        id: 'info/whos-here',
        title: '“Who’s Here” Directory'
      },
      {
        type: 'menu-head',
        title: 'Job Information Center'
      },
      {
        id: 'info/jobs',
        title: 'Fairmont, Imperial Ballroom, level B2'
      },
      {
        type: 'menu-head',
        title: 'Exhibits'
      },
      {
        id: 'info/exhibit-hall',
        title: 'Exhibit Hall'
      },
      {
        id: 'program/eh',
        title: 'Exhibit Hall Theater'
      },
      {
        id: 'info/mla-booth',
        title: 'MLA Exhibit Booth (Booth 100)'
      },
      {
        type: 'menu-head',
        title: 'Event Highlights'
      },
      {
        id: 'info/excursions',
        title: 'Cultural Excursions'
      },
      {
        id: '660',
        title: 'MLA Awards Ceremony (Session 660)'
      },
      {
        id: '421',
        title: 'Presidential Address (Session 421)'
      },
      {
        id: '230',
        title: 'Presidential Forum (Session 230)'
      },
      {
        id: '155A',
        title: 'A Screening of <em>Eight Men Out</em>, a Film by John Sayles (Session 155A)'
      },
      {
        type: 'menu-head',
        title: 'Informational Sessions and Workshops'
      },
      {
        id: 'info/humanities-summit',
        title: 'Chicago Humanities Summit'
      },
      {
        id: 'info/celj',
        title: 'Council of Editors of Learned Journals'
      },
      {
        id: 'info/career-options-phds',
        title: 'Discussion of Career Options for Humanities PhDs'
      },
      {
        id: 'info/ele',
        title: 'Electronic Literature Exhibit: <em>Pathfinders: Twenty-Five Years of Experimental Literary Art</em>'
      },
      {
        id: 'info/government-careers',
        title: 'Government Careers'
      },
      {
        id: 'info/neh',
        title: 'NEH Information'
      },
      {
        type: 'menu-head',
        title: 'Governance'
      },
      {
        id: 'info/delegate-assembly',
        title: 'Delegate Assembly'
      },
      {
        type: 'menu-head',
        title: 'Emergencies'
      },
      {
        id: 'info/medical',
        title: 'Illness and Medical Emergencies'
      },
      {
        type: 'menu-head',
        title: '2015 Convention in Vancouver'
      },
      {
        id: 'info/calls-for-papers',
        title: 'Calls for Papers'
      },
      {
        id: 'info/organizing-sessions',
        title: 'Organizing Sessions'
      },
      {
        id: 'info/vancouver',
        title: 'Vancouver Information'
      }
    ]
  };

  Menu.Maps = {
    sheraton: [
      {
        type: 'head',
        title: 'Sheraton Chicago'
      },
      {
        href: '/img/maps/sheraton-2.png',
        title: 'Meeting Room Level 2'
      },
      {
        href: '/img/maps/sheraton-3.png',
        title: 'Lobby Level 3'
      },
      {
        href: '/img/maps/sheraton-4.png',
        title: 'Ballroom Level 4'
      }
    ],
    marriott: [
      {
        type: 'head',
        title: 'Chicago Marriott'
      },
      {
        href: '/img/maps/marriott-2.png',
        title: '2nd Floor'
      },
      {
        href: '/img/maps/marriott-3.png',
        title: '3rd Floor'
      },
      {
        href: '/img/maps/marriott-4.png',
        title: '4th Floor'
      },
      {
        href: '/img/maps/marriott-5.png',
        title: '5th Floor'
      },
      {
        href: '/img/maps/marriott-6.png',
        title: '6th Floor'
      },
      {
        href: '/img/maps/marriott-7.png',
        title: '7th Floor'
      },
      {
        href: '/img/maps/marriott-10.png',
        title: '10th Floor'
      }
    ],
    fairmont: [
      {
        type: 'head',
        title: 'Fairmont Chicago'
      },
      {
        href: '/img/maps/fairmont-b2.png',
        title: 'Level B2'
      },
      {
        href: '/img/maps/fairmont-2.png',
        title: 'Level 2'
      }
    ]
  };

});
