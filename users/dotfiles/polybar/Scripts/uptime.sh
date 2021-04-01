#!/bin/sh
uptime | sed 's/up //; s/\ days\?,/d/; s/\ hours\?,\?/h/; s/\ minutes\?/m/'
