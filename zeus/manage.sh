#!/bin/bash

main_menu()
{
  echo -e "Zeus script initialized, please enter option:"
  echo -e "        - startup -------> starts app"
  echo -e "        - test ----------> runs all tests"
  echo -e "        - exit ----------> exit zeus script"
}

startup()
{
  echo -e "starting rabbitmq...."
  rabbitmq-server start &
  echo -e "Enter password for queue..."
  read password
  serviced service attach rabbitmq
  rabbitmqctl change_password zenoss $password &
  echo -e "starting janus...."
  ruby janus/server_wrapper.rb &
  echo -e "starting apollo...."
  python apollo/qtpy_wrapper/main.py &
  echo -e "starting demeter...."
  python demeter/manage.py runserver &
  echo -e "starting hera...."
  cd hera && rails s &
  echo -e "starting zeus...."
  cd ../ && ruby zeus/god.rb &
  echo -e "starting daedalus...."
}

runtests()
{

}

display()
{
  main_menu()
  read option
  case $option in
    startup)
      echo -e "starting application...."
      startup()
      echo -e "would you like to test? (y/n)"
      read testanswer
      if [ $testanswer = "y" ]; then
        runtests()
      elif [ $testanwer = "n" ]; then
        done
      else
        echo -e "Invalid response, reinitialize script with parameter 'test' to test"
        done
      fi
      ;;
    test)
      echo -e "testing..........."

      ;;
    exit)
      done
      ;;
    *)
      echo "Invalid option '" $option "' selected"
      done
      ;;
  esac
}

display()
