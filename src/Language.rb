require "i18n"

module Language

   attr_reader :language

   def default_language
      I18n.load_path = Dir['../lang/lang_*.yml']
      raise ::Error::NoLanguageFoundError if I18n.available_locales.empty?
      @language = I18n.available_locales[0]
      I18n.locale = @language
   end

   def language_choice
      I18n.load_path = Dir['../lang/lang_*.yml']
      raise ::Error::NoLanguageFoundError if I18n.available_locales.empty?
      I18n.available_locales
   end

   def language_choice_by_name
      langs = {}
      language_choice.each do |v|
         langs[I18n.translate('language.name', :locale => v)] = v
      end
      langs
   end

   def update_language(new_language)
      raise ::Error::NonAvailableLanguageError unless language_choice.include?(new_language)
      @language = new_language
      I18n.locale = @language
   end

   alias_method :language=, :update_language
end
