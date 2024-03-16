cmake_minimum_required(VERSION 3.16)
project(cutie-settings VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml LinguistTools)

qt_standard_project_setup()

set(cutie-settings_SOURCES 
        src/main.cpp
)

qt_add_resources(APP_RESOURCES 
	${CMAKE_SOURCE_DIR}/src/qml/qml.qrc)

qt_add_executable(cutie-settings ${cutie-settings_SOURCES} ${APP_RESOURCES})

qt_add_translations(cutie-settings
    TS_FILES ${CMAKE_SOURCE_DIR}/translations/cutie-settings_fi.ts)

target_include_directories(cutie-settings PUBLIC src)

target_link_libraries(cutie-settings PUBLIC Qt::Core Qt::Quick Qt::Qml)

install(TARGETS cutie-settings RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")
install(FILES cutie-settings.desktop DESTINATION "${CMAKE_INSTALL_DATADIR}/applications")
install(FILES cutie-settings.svg DESTINATION "${CMAKE_INSTALL_DATADIR}/icons/hicolor/scalable/apps")