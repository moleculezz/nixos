{ pkgs, config, lib, ... }:

{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";
      height = 24;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = ["hyprland/window"];
      modules-right = [ "mpd" "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "keyboard-state" "battery" "tray" "custom/notification" "clock" ];
      "hyprland/workspaces" = {
        on-click = "activate";
        active-only = false;
        all-outputs = true; 
      	format = "{}";
      	format-icons = {
          default = "";
          active = "";
          urgent = "";
      	};
      	# on-scroll-up = "hyprctl dispatch workspace e+1";
      	# on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "clock" = {
        format = "{:%H:%M %a}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };
      "hyprland/window" = {
      	# max-length = 25;
      	separate-outputs = false;
      };
      "keyboard-state" = {
        numlock = true;
        capslock = true;
        format = "{name} {icon}";
        format-icons = {
            locked = "";
            unlocked = "";
        };
      };
      "tray" = {
        icon-size = 21;
        spacing = 10;
      };
      "custom/system" = {
        format = "";
        tooltip = false;
      };
      "memory" = {
      	interval = 5;
      	format = "   {}%";
        on-click = "alacritty -e btop";
      };
      "cpu" = {
      	interval = 5;
      	format = "   {usage}%";
        on-click = "alacritty -e btop";
      };
      "disk" = {
        format = " {percentage_free}";
        on-click = "alacritty -e btop";
      };
      "group/hardware" = {
        orientation = "inherit";
        drawer = {
            transition-duration = 300;
            children-class = "not-memory";
            transition-left-to-right = false;
        };
        modules = [ "custom/system" "disk" "cpu" "memory" ];
      };
      #"network" = {
      #  format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
      #  format-ethernet = " {bandwidthDownOctets}";
      #  format-wifi = "{icon}  {signalStrength}%";
      #  format-disconnected = "󰤮";
      #  tooltip = false;
      #};
      "network" = {
        format = "{ifname}";
        format-wifi = "    {signalStrength}%";
        format-ethernet = "  {ifname}";
        format-disconnected = "Disconnected";
        tooltip-format = " {ifname} via {gwaddri}";
        tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
        tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
        tooltip-format-disconnected = "Disconnected";
        max-length = 50;
        on-click = "nm-connection-editor";
      };
      "pulseaudio" = {
        format = "{icon}  {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        #format-muted = " {format_source}";
        #format-source = "  {volume}%";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
            activated = " ";
            deactivated = " ";
        };
        tooltip = "true";
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} {}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = " ";
          dnd-notification = " <span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = " <span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = " <span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
       	};
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t";
        escape = true;
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        on-click = "";
        tooltip = false;
      };
    }];
  };
}
