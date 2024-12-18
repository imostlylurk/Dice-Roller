
target_sources(${CMAKE_PROJECT_NAME} PUBLIC
    "main.cpp"
    diceroller.h
    diceroller.cpp
)

include_directories(SYSTEM
    ${CMAKE_SOURCE_DIR}/App
)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::CorePrivate
)
