
# ======================================================

add_executable(main  main.cpp)
add_custom_target(run
                  COMMAND main)

# ======================================================

#add_definitions(-g -std=c++11 -Wall  -O3)      # compile flags

#set()
#add_library()

# ======================================================

set_target_properties(main  PROPERTIES COMPILE_FLAGS "-std=c++11")

install(TARGETS   main
        RUNTIME   DESTINATION   bin)

# ======================================================

#find_library(DB_CXX
    #NAMES  db_cxx
    #PATHS)

#target_link_libraries(create-index ${DB_CXX})

# ======================================================
