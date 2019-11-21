ON INIT {
  SETNAME "Flying creature"
  
  PHYSICAL RADIUS 30

  SET_BLOOD 0.9 0.9 0.1
  SETIRCOLOR 1.0 0.0 0.0

  SET_NPC_STAT armor_class 10
  SET_NPC_STAT absorb 20
  SET_NPC_STAT damages 2
  SET_NPC_STAT tohit 40
  SET_NPC_STAT aimtime 800
  SET_NPC_STAT life 5
  SET_NPC_STAT reach 20
  SET_NPC_STAT RESISTFIRE 100
  SET_NPC_STAT RESISTPOISON 100

  SET_XP_VALUE 60

  SET_WEAPON_MATERIAL CLAW
  SET_MATERIAL FLESH
  SET_ARMOR_MATERIAL LEATHER
  SET_STEP_MATERIAL Foot_bare
  
  SETDETECT 40
  
  INVENTORY CREATE

  LOADANIM WALK                       "flying_normal_walk"
  LOADANIM RUN                        "bee_walk"
  LOADANIM WAIT                       "flying_normal_wait"
  LOADANIM FIGHT_WAIT                 "flying_normal_wait"
  LOADANIM DIE                        "flying_die_classic"

  LOADANIM BARE_READY                 "bee_fight_attack_start"
  LOADANIM BARE_UNREADY               "bee_fight_attack_strike"
  LOADANIM BARE_WAIT                  "bee_fight_wait_toponly"
  LOADANIM BARE_STRIKE_LEFT_START     "bee_fight_attack_start" 
  LOADANIM BARE_STRIKE_LEFT_CYCLE     "bee_fight_attack_cycle"
  LOADANIM BARE_STRIKE_LEFT           "bee_fight_attack_strike"
  LOADANIM BARE_STRIKE_RIGHT_START    "bee_fight_attack_start"
  LOADANIM BARE_STRIKE_RIGHT_CYCLE    "bee_fight_attack_cycle"
  LOADANIM BARE_STRIKE_RIGHT          "bee_fight_attack_strike"
  LOADANIM BARE_STRIKE_TOP_START      "bee_fight_attack_start"
  LOADANIM BARE_STRIKE_TOP_CYCLE      "bee_fight_attack_cycle"
  LOADANIM BARE_STRIKE_TOP            "bee_fight_attack_strike"
  LOADANIM BARE_STRIKE_BOTTOM_START   "bee_fight_attack_start"
  LOADANIM BARE_STRIKE_BOTTOM_CYCLE   "bee_fight_attack_cycle"
  LOADANIM BARE_STRIKE_BOTTOM         "bee_fight_attack_strike"

  SETTARGET NONE
  BEHAVIOR WANDER_AROUND 500
  SETMOVEMODE WALK

  ACCEPT
}

ON HEAR {
  HEROSAY "I hear you!"

  BEHAVIOR MOVE_TO
  SETTARGET -n ^SENDER
  SETMOVEMODE WALK
  
  ACCEPT
}

ON DETECTPLAYER {
  >>PLAYER_DETECTED
  
  GOTO ATTACK_PLAYER
  
  ACCEPT
}

ON ATTACK_PLAYER {
  GOTO ATTACK_PLAYER
  ACCEPT
}

>>ATTACK_PLAYER {
  HEROSAY "Attack player!"
  
  WEAPON ON
  SET_EVENT HEAR OFF
  BEHAVIOR -f MOVE_TO
  SETTARGET PLAYER
  SETMOVEMODE RUN
  
  ACCEPT
}

ON MOVE {
  SETMOVEMODE WALK
  ACCEPT
}


ON LOSTTARGET {
  GOTO LOOK_FOR
  ACCEPT
}

ON LOOK_FOR {
  GOTO LOOK_FOR
  ACCEPT
}

ON UNDETECTPLAYER {
  GOTO LOOK_FOR
  ACCEPT
}

>>LOOK_FOR {
  HEROSAY "Looking for ya!"
  
  IF (^DIST_PLAYER < 500) GOTO PLAYER_DETECTED
 
  BEHAVIOR LOOK_FOR 500
  SETTARGET PLAYER
  SETMOVEMODE WALK

  SET_EVENT HEAR ON

  ACCEPT
}

ON DIE {
  FORCEANIM DIE
  ACCEPT
}

ON REACHEDTARGET {
  GOTO PLAYER_DETECTED
  ACCEPT
}

ON OUCH {
  SPELLCAST -sf 5 POISON_PROJECTILE PLAYER
  ACCEPT
}