class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateNoteEcxeption extends CloudStorageException {}

class CouldNotGetAllNotesException extends CloudStorageException {}

class CouldNotUpdateNoteEcxeption extends CloudStorageException {}

class CouldNotDeleteNoteEcxeption extends CloudStorageException {}
