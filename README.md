# Différences avec StreamLauncher

Je repars sur une nouvelle base, on refait StreamLauncher en orienté objet.

Je fais ça pour faciliter l'implémentation de différentes interfaces.
Donc on va partir sur un simulacre de MVC.

Dans un premier temps, je vais faire une Command Line Interface ainsi qu'une interface graphique
en Tk puisque c'est dans la librairie standard de Ruby, et que créer un exécutable avec Shoes
donne quelque chose d'aléatoire (code dans l'exécutable plus vieux que le code utilisé pour le
créer).

Je crois qu'une gemme nommée ocra permettra de créer l'exécutable.

Essayer aussi permettre le choix de langue : Français ou Anglais

# Classes manquantes

Une classe controller pour une StreamList (+ Stream) (commune à toutes les vues ? ou unique à chaque vue ?) et une autre pour la gestion de l'OS et des chemins vers livestreamer et navigateur.
Une classe par vue

# Problèmes

Twitch a changé son API donc livestreamer ne marche plus sans token, je vais utiliser
le token associé à livestreamer pour être moins emmerdant.

# Multi langues

Grâce à la réponse de svenfuchs sur [stackoverflow](https://stackoverflow.com/questions/6425225/ruby-localization-i18n-g18n-gettext-padrino-whats-the-difference?answertab=active#tab-top)
Je vois qu'il faut utiliser i18n plutôt que gettext pour utiliser plusieurs langues

Voici un extrait d'un guide plus complet, pour l'utiliser en Ruby simple (pas spécifique à Rails) :
[Internationalization for Ruby – i18n gem](https://lingohub.com/blog/2013/08/internationalization-for-ruby-i18n-gem/)



### Internationalization for Ruby: The Ruby i18n gem

One of the most popular Ruby gems for internationalization is [Ruby I18n](https://github.com/svenfuchs/i18n). It allows translation and localization, interpolation of values to translations, pluralization, customizable transliteration to ASCII, flexible defaults, bulk lookup, lambdas as translation data, custom key/scope separator, and custom exception handlers.

The gem is split in two parts: the public API and a default backend (named Simple backend). Other backends can be used, such as Chain, ActiveRecord, KeyValue or a custom backend can be implemented.

**YAML** (.yml) or plain Ruby (.rb) files are used for storing translations in SimpleStore, but YAML is the preferred option among Ruby developers.

### Internationalization and the YAML resource file format

YAML is a human-readable data serialization format. Its syntax was designed to be easily mapped to data types common to most high-level languages (lists, associative arrays and scalars). Unlike some other formats, YAML has a [well defined standard](http://yaml.org/spec/1.2/spec.html).

Key features of YAML resource file format are:

- the information is stored in key-value pairs delimited with colon ( : )
- keys can be (and usually are) nested (scoped)
- i18n expects the root key to correspond to the locale of the content, for example ‘en-US’ or ‘de’
- the “leaf key” (the one that has no “children” keys) has to have some value
- values can be escaped
- correct and consistent line indentation is important for preserving the key hierarchy
- lines starting with a hash sign ( # ) preceded with any number of white-spaces are ignored by the parser (treated as a comment)
- place-holder syntax is: %{name}, where “name” can consist of multiple non-white-space characters
- UTF-8 encoding is usually used for YAML resource files

Before we move on to demonstrate the I18n methods, lets first create an example yaml file that we will load and test:

```raml
---
en:
  greetings:
    hello:
      world: Hello World!
      friend: Hello Friend!
      user: Hello %{user}
  inbox:
    messages:
      one: You have one message in your inbox.
      other: You have %{count} messages in your inbox.
  time:
    am: a.m.
    formats:
      default: ! '%a, %d %b %Y %H:%M:%S %z'
      long: ! '%B %d, %Y %H:%M'
      short: ! '%d %b %H:%M'
    pm: p.m.
  date:
    abbr_day_names:
    - Sun
    - Mon
    - Tue
    - Wed
    - Thu
    - Fri
    - Sat
    abbr_month_names:
    -
    - Jan
    - Feb
    - Mar
    - Apr
    - May
    - Jun
    - Jul
    - Aug
    - Sep
    - Oct
    - Nov
    - Dec
    day_names:
    - Sunday
    - Monday
    - Tuesday
    - Wednesday
    - Thursday
    - Friday
    - Saturday
    formats:
      birth: ! '%d.%m.'
      default: ! '%Y-%m-%d'
      long: ! '%B %d, %Y'
      month_and_year: ! '%b %Y'
      short: ! '%b %d'
    month_names:
    -
    - January
    - February
    - March
    - April
    - May
    - June
    - July
    - August
    - September
    - October
    - November
    - December
    order:
    - year
    - month
    - day
```

view rawen.yml hosted with ❤ by GitHub

### Installation and setup

```
gem install i18n
```

After the gem installation, change the directory to the location where the sample yaml file was saved and start the **irb** (interactive ruby shell). The first step is requiring the library:

```
2.0.0p247 :001 > require 'i18n'
 => true
```

Next, we can check the current [locale](https://lingohub.com/industry-updates/2013/02/how-locales-turn-the-internet-into-a-global-village/). By default, it is English.

```
2.0.0p247 :002 > I18n.locale
 => :en
```

Changing it to something else is easy:

```
2.0.0p247 :003 > I18n.locale = :de
 => :de
```

## Translation lookup

Translation lookup is done via the translate method of I18n. There is also a shorter alias available: **I18n.t**. Let’s now try to lookup one of the phrases from our yaml file example:

```
2.0.0p247 :004 > I18n.translate :world, :scope => 'greetings.hello'
 => "translation missing: en.hello.world"
```

The translation is missing, because we have not loaded the file. Lets load all the .yaml and .rb files in the current directory:

```
2.0.0p247 :005 > I18n.load_path = Dir['./*.yml', './*.rb']
 => ["./en.yml"]
```

and then we retry accessing the English translation with the key ‘world’:

```
2.0.0p247 :006 > I18n.translate :world, :scope => 'greetings.hello'
 => "Hello world!"
```

When we asked for this translation, we did not pass any locale, so I18n.locale was used. A locale can be explicitly passed:

```
2.0.0p247 :007 > I18n.translate :world, :scope => 'greetings.hello', :locale => :en
 => "Hello world!"
```

When passing the phrase key, a symbol or a string can be used, and a scope can be an array or dot-separated. Also all combinations of these are valid, so the following calls are equivalent:

```
I18n.translate 'greetings.hello.world'
I18n.translate 'hello.world', :scope => :greetings
I18n.translate 'hello.world', :scope => 'greetings'
I18n.translate :world, :scope => 'greetings.hello'
I18n.translate :world, scope: [:greetings, :hello]
```

When a :default option is given, its value will be returned if the translation is missing. If the :default value is a symbol, it will be used as a key and translated. Multiple values can be provided as default. The first one that results in a value will be returned. For example, the following first tries to translate the key :missing and then the key :also_missing. As both do not yield a result, the string “Not here” will be returned:

```
2.0.0p247 :008 > I18n.translate :missing, default: [:also_missing, 'Not here']
 => 'Not here'
```

Variables can be interpolated to the translation like this:

```
2.0.0p247 :009 > I18n.translate :user, :scope => [:greetings, :hello], :user => 'Ela'
 => "Hello Ela!"
```

To look up multiple translations at once, an array of keys can be passed:

```
2.0.0p247 :010 > I18n.translate [:world, :friend], :scope => [:greetings, :hello]
 => ["Hello World!", "Hello Friend!"]
```

Also, a key can translate to a (potentially nested) hash of grouped translations:

```
2.0.0p247 :011 > I18n.translate :hello, :scope => [:greetings]
 => {:world=>"Hello World!", :user=>"Hello %{user}", :friend=>"Hello Friend!"}
```

### Pluralization options in internationalization for Ruby

In English there is only one singular and one plural form for a given string, e.g. “1 message” and “2 messages”. Other languages ([Arabic](http://unicode.org/repos/cldr-tmp/trunk/diff/supplemental/language_plural_rules.html#ar), [Japanese](http://unicode.org/repos/cldr-tmp/trunk/diff/supplemental/language_plural_rules.html#ja), Russian and many more) have different grammars that have additional or fewer [plural forms](http://unicode.org/repos/cldr-tmp/trunk/diff/supplemental/language_plural_rules.html). Thus, the I18n API provides a flexible pluralization feature.

The :count interpolation variable has a special role in that it both is interpolated to the translation and used to pick a pluralization from the translations according to the pluralization rules:

```
2.0.0p247 :012 > I18n.translate :messages, :scope => :inbox, :count => 1
 => "You have one message in your inbox."
2.0.0p247 :013 > I18n.translate :messages, :scope => :inbox, :count => 39
 => "You have 39 messages in your inbox."
```

The algorithm for pluralizations in `:en` is as simple as: entry[count == 1 ? 0 : 1]. The translation denoted as ‘one‘ is regarded as singular, the ‘other’ is used as plural (including the count being zero).

### Setting up Date and Time Localization

To localize the time format, the Time object should be passed to I18n.localize. A format can be picked by passing the :format option — by default the :default format is used.

```
2.0.0p247 :014 > I18n.localize Time.now
 => "Wed, 14 Aug 2013 13:34:49 +0200"
2.0.0p247 :015 > I18n.localize Time.now, :format => :short
 => "14 Aug 13:34"
```

Instead of I18n.localize, a shorter alias can be used: **I18n.l**.
