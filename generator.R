schedule <- read.csv("https://docs.google.com/spreadsheets/d/1gJqIkW3PRWrYfLL0Tq2IQImxHQeqq11_RUEntXJjrh0/pub?output=csv", stringsAsFactors=F)
stories <- read.csv("https://docs.google.com/spreadsheets/d/1gJqIkW3PRWrYfLL0Tq2IQImxHQeqq11_RUEntXJjrh0/pub?gid=744080895&single=true&output=csv", stringsAsFactors=F)
homework <- read.csv("https://docs.google.com/spreadsheets/d/1gJqIkW3PRWrYfLL0Tq2IQImxHQeqq11_RUEntXJjrh0/pub?gid=2030209779&single=true&output=csv", stringsAsFactors=F)
lab <- read.csv("https://docs.google.com/spreadsheets/d/1gJqIkW3PRWrYfLL0Tq2IQImxHQeqq11_RUEntXJjrh0/pub?gid=1019049404&single=true&output=csv", stringsAsFactors=F)
lectures <- read.csv("https://docs.google.com/spreadsheets/d/1gJqIkW3PRWrYfLL0Tq2IQImxHQeqq11_RUEntXJjrh0/pub?gid=1150744298&single=true&output=csv", stringsAsFactors=F)


for (i in 1:nrow(schedule)) {
  
  
  markdown <- "# Introduction to Data Journalism
  
  #### Wesleyan University - Spring 2017
  
  **Andrew Ba Tran and Robert Kabacoff**
  
  "
  
  class_sheet <- subset(schedule, Class==i)
  class_stories <- subset(stories, Class==i)
  class_hw <- subset(homework, Class==i)
  class_lab <- subset(lab, Class==i)
  class_lect <- subset(lectures, Class==i)
  
  
  
  if(nrow(class_sheet)!=0) {
    
    class_markdown <- paste0("## Class ", class_sheet$Class, "
                             ", class_sheet$Day, " - ", class_sheet$Date, "
                             
                             ----
                             
                             ### ", class_sheet$Section, "
                             
                             #### ", class_sheet$Purpose, "
                             
                             Goal: ", class_sheet$Details, "
                             
                             #### ", ifelse(grepl("R: ", as.character(class_sheet$Purpose)), "Lab", "Discussion"), "
                             ")
  }
  if(nrow(class_stories)!=0) {
    stories_markdown <- "
    "
    for (x in 1:nrow(class_stories)) {
      stories_markdown <- paste0(stories_markdown, "*", class_stories$Title[x], "[[", class_stories$Type[x], "](", class_stories$Link[x], ")]
                                 ")
      
    }
    
    class_markdown <- paste0(class_markdown, stories_markdown)
    
  }
  
  if(nrow(class_lab)!=0) {
    lab_markdown <- "
    "
    for (x in 1:nrow(class_lab)) {
      lab_markdown <- paste0(lab_markdown[x], "*", class_lab$Title[x], "[[", class_lab$Type[x], "](", class_lab$Link[x], ")]
                             ")
      
    }
    
    lab_markdown <- paste0(class_markdown, lab_markdown)
    
  }
  
  if(nrow(class_hw)!=0) {
    hw_markdown <- paste0("
#### Homework
                          
                          |Type|Where|Details|
                          |---|---|---|")
    for (x in 1:nrow(class_hw)) {
      hw_markdown <- paste0(hw_markdown,
                            "
                            |", class_hw$Type[x], "|", class_hw$Where[x], "|", ifelse(is.na(class_hw$Link[x]), class_hw$Specifics[x], paste0("[", class_hw$Specifics[x], "](", class_hw$Link[x], ")|")))
    }
    
    class_markdown <- paste0(class_markdown, hw_markdown)
    }
  
  if (i == 1) {
    exit <- "
    
    **[Next class](class2.md)**"
  } else if (i==nrow(schedule)) {
    exit <- "
    
    **[Previous class](class28.md)**"
  } else {
    exit <- paste0("
                   
                   **[Previous class](class", i-1, ".md)** | **[Next class](", i+1, ".md)**")
  }
  
  markdown <- paste0(markdown, class_markdown, exit)  
  write(markdown, paste0("class/class", i, ".md"))
  
  }
