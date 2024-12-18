
target_sources(${CMAKE_PROJECT_NAME} PUBLIC
    "main.cpp"
    ScaleUI.h
    diceroller.h
    diceroller.cpp
)

if (ANDROID)
    include_directories(SYSTEM
        ${CMAKE_SOURCE_DIR}/android/src
        ${CMAKE_SOURCE_DIR}/App
    )

    target_sources(${CMAKE_PROJECT_NAME} PRIVATE
        "${CMAKE_SOURCE_DIR}/android/src/AndroidJNI.h"
    )
endif()

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::CorePrivate
)
