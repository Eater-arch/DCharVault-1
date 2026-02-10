#ifndef DIARYMANAGER_H
#define DIARYMANAGER_H

#include<vector>
#include<string>
#include"DiaryEntry.h"

enum class DiaryError{
    None, 

    // Validation
    EmptyId, 
    EmptyTitle, 
    EmptyContent, 
    InvalidId, 
    InvalidDateTime, 

    // Generation 
    IdGenerationFailed, 
    DateTimeGenerationFailed, 

    // State 
    EntryNotFound, 
    EntryAlreadyExists, 

    // Persistence 
    SerializationFailed, 
    DeserializationFailed, 
    
    // Security 
    EncryptionFailed, 
    DecryptionFailed, 
    IntegrityCheckFailed,
};

struct DiaryEntrySummary {
    std::string_view id;
    std::string_view title;
    int64_t createdAt;
    int64_t updatedAt;
    bool bookmarked;
};

class DiaryManager{
    public:
        const std::vector<DiaryEntrySummary>& readEntrySummaries() const noexcept; // may use this for reading entries
        // const std::vector<DiaryEntry>& readEntries() const noexcept;
        const DiaryEntry* readEntry(const std::string& id) const noexcept;
        const DiaryEntry* createEntry(const std::string& title, const std::string& content); // returns reference to newely created entry(reference to the stored object, not a temporary)
        //[[nodiscard]] : if someone ignore return value error then warn them!!
        [[nodiscard]] DiaryError updateEntry(const std::string& id, const std::string& title, const std::string& content);
        [[nodiscard]] DiaryError deleteEntry(const std::string& id);
    
    private:
        std::vector<DiaryEntry> entries;
        

};

#endif


/*
┌───────────────┐
│ DiaryManager  │   owns entries
│               │
│  vector<DiaryEntry>
│               │
│  ├── readEntry(id)        -> full entry
│  ├── create/update/delete
│  └── readEntrySummaries() -> UI list
└───────────────┘

*/