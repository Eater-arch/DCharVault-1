#ifndef DIARYENTRY_H
#define DIARYENTRY_H
#include<string>
#include<cstdint> 


struct DiaryEntry{
    bool bookmarked = false;
    int64_t createdAt;
    int64_t updatedAt;
    std::string id;
    std::string title;
    std::string content;
};


#endif