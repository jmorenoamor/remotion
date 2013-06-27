#!/bin/sh
################################################################################
# Remotion
# Function library for interacting with remote hosts through OpenSSH and Expect
#
# Jesús Moreno Amor <jesus@morenoamor.com>
# v1.0
# June 2013
#
################################################################################

################################################################################
# Configuration
################################################################################
RM_EXPECT="/usr/bin/expect -c"

RM_SSH="/usr/bin/ssh -q -C"
RM_SCP="/usr/bin/scp -q -C"

################################################################################
# Expect configuration
################################################################################
# Disable the expect logging being sent to stdout, set to 1 to enable it
EXP_LOG_USER="0"

# Disable the echo produced by the spawn command set to "" to enable it
EXP_NOECHO="-noecho"

################################################################################
# Execute a command in a remote host
################################################################################
function remote_execute(){
  USER=${1:-"NONE"}
  PASSWORD=${2:-"NONE"}
  HOST=${3:-"NONE"}
  REMOTE_COMMAND=${4:-"NONE"}

  [[ "$USER" != "NONE" ]] || { exit 1; }
  [[ "$PASSWORD" != "NONE" ]] || { exit 2; }
  [[ "$HOST" != "NONE" ]] || { exit 3; }
  [[ "$REMOTE_COMMAND" != "NONE" ]] || { exit 4; }

  SSH_COMMAND="$RM_SSH $USER@$HOST \"${REMOTE_COMMAND}\""

  $RM_EXPECT "log_user $EXP_LOG_USER; set timeout -1; spawn $EXP_NOECHO $SSH_COMMAND; expect \"*?assword:*\"; send -- \"${PASSWORD}\r\"; send -- \"\r\"; expect eof"

  return 0
}

################################################################################
# Get a file from a remote host
################################################################################
function remote_getfile(){
  USER=${1:-"NONE"}
  PASSWORD=${2:-"NONE"}
  HOST=${3:-"NONE"}
  REMOTE_FILE=${4:-"NONE"}
  LOCAL_FILE=${5:-"."}

  [[ "$USER" != "NONE" ]] || { exit 1; }
  [[ "$PASSWORD" != "NONE" ]] || { exit 2; }
  [[ "$HOST" != "NONE" ]] || { exit 3; }
  [[ "$REMOTE_FILE" != "NONE" ]] || { exit 4; }

  SCP_COMMAND="$RM_SCP $USUARIO@$HOST:$REMOTE_FILE $LOCAL_FILE"

  $RM_EXPECT "log_user $EXP_LOG_USER; set timeout -1; spawn $EXP_NOECHO $SCP_COMMAND; expect \"*?assword:*\"; send -- \"${PASSWORD}\r\"; send -- \"\r\"; expect eof"

  return 0
}

################################################################################
# Put a file to a remote host
################################################################################
function remote_putfile(){
  USER=${1:-"NONE"}
  PASSWORD=${2:-"NONE"}
  HOST=${3:-"NONE"}
  LOCAL_FILE=${4:-"NONE"}
  REMOTE_FILE=${5:-"NONE"}

  [[ "$USER" != "NONE" ]] || { exit 1; }
  [[ "$PASSWORD" != "NONE" ]] || { exit 2; }
  [[ "$HOST" != "NONE" ]] || { exit 3; }
  [[ "$LOCAL_FILE" != "NONE" ]] || { exit 4; }
  [[ "$REMOTE_FILE" != "NONE" ]] || { exit 5; }

  SCP_COMMAND="$RM_SCP $LOCAL_FILE $USUARIO@$HOST:$REMOTE_FILE"

  $RM_EXPECT "log_user $EXP_LOG_USER; set timeout -1; spawn $EXP_NOECHO $SCP_COMMAND; expect \"*?assword:*\"; send -- \"${PASSWORD}\r\"; send -- \"\r\"; expect eof"

  return 0
}
