//Species names
#define SPECIES_HUMAN "Human"
#define SPECIES_TAJARA "Tajara"
#define SPECIES_DIONA "Diona"
#define SPECIES_VOX "Vox"
#define SPECIES_VOXPARIAH "Vox Pariah"
#define SPECIES_IPC "Machine"
#define SPECIES_UNATHI "Unathi"
#define SPECIES_SKRELL "Skrell"

#define SPECIES_MONKEY "Monkey"
#define SPECIES_FARWA "Farwa"
#define SPECIES_NEAERA "Neaera"
#define SPECIES_STOK "Stok"

#define STATION_ORGANIC_SPECIES list(SPECIES_HUMAN, SPECIES_TAJARA, SPECIES_SKRELL, \
	SPECIES_MONKEY, SPECIES_FARWA, SPECIES_NEAERA, SPECIES_STOK)

// Species flags.
#define NO_BREATHE        1     // Cannot suffocate or take oxygen loss.
#define NO_SCAN           2     // Cannot be scanned in a DNA machine/genome-stolen.
#define NO_PAIN           4     // Cannot suffer halloss/recieves deceptive health indicator.
#define NO_SLIP           8    // Cannot fall over.
#define NO_POISON         16    // Cannot not suffer toxloss.
#define HAS_SKIN_TONE     32    // Skin tone selectable in chargen. (0-255)
#define HAS_SKIN_COLOR    64   // Skin colour selectable in chargen. (RGB)
#define HAS_LIPS          128   // Lips are drawn onto the mob icon. (lipstick)
#define HAS_UNDERWEAR     256   // Underwear is drawn onto the mob icon.
#define IS_PLANT          512  // Is a treeperson.
#define IS_WHITELISTED    1024  // Must be whitelisted to play.
#define IS_SYNTHETIC      2048  // Is a machine race.
#define HAS_EYE_COLOR     4096  // Eye colour selectable in chargen. (RGB)
#define CAN_JOIN          8192 // Species is selectable in chargen.
#define IS_RESTRICTED     16384 // Is not a core/normally playable species. (castes, mutantraces)

// Languages.
#define LANGUAGE_GALCOM "Galactic Common"
#define LANGUAGE_EAL "Encoded Audio Language"
#define LANGUAGE_SOL_COMMON "Sol Common"
#define LANGUAGE_UNATHI "Sinta'unathi"
#define LANGUAGE_SIIK_MAAS "Siik'maas"
#define LANGUAGE_SIIK_TAJR "Siik'tajr"
#define LANGUAGE_SKRELLIAN "Skrellian"
#define LANGUAGE_ROOTSPEAK "Rootspeak"
#define LANGUAGE_TRADEBAND "Tradeband"
#define LANGUAGE_GUTTER "Gutter"
#define LANGUAGE_CULT "Cult"
#define LANGUAGE_SIIK_MAAS "Siik'maas"
#define LANGUAGE_SURZHYK "Surzhyk"

// Language flags.
#define WHITELISTED 1   // Language is available if the speaker is whitelisted.
#define PUBLIC      2   // Language can be accquired by anybody without restriction.
#define NONVERBAL   4   // Language has a significant non-verbal component. Speech is garbled without line-of-sight.
#define SIGNLANG    8   // Language is completely non-verbal. Speech is displayed through emotes for those who can understand.
#define HIVEMIND    16  // Broadcast to all mobs with this language.
#define NONGLOBAL   32  // Do not add to general languages list.
#define INNATE      64  // All mobs can be assumed to speak and understand this language. (audible emotes)
#define NO_TALK_MSG 128 // Do not show the "\The [speaker] talks into \the [radio]" message
#define NO_STUTTER  256 // No stuttering, slurring, or other speech problems
#define COMMON_VERBS 512 // Robots will apply regular verbs to this.

//Species size
#define SMALL  1 // mouse
#define MEDIUM 2 // human
#define LARGE  4 // 2 humans


