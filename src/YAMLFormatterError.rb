class YAMLFormatterError < StreamLauncherError
   class FileAlreadyExistError < YAMLFormatterError; end
   class NonexistentError < YAMLFormatterError; end
end
