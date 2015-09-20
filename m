Date: Sun, 20 Sep 2015 22:39:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Hao Nguyen <conghaobk@gmail.com>
Cc: rtc-linux <rtc-linux@googlegroups.com>
Subject: Re: [rtc-linux] Synchronization system time to rtc in Linux
Message-ID: <20150920203906.GL4287@piout.net>
References: <e108d983-f05c-409a-9f98-e86487e6099f@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e108d983-f05c-409a-9f98-e86487e6099f@googlegroups.com>
List-ID: <rtc-linux.googlegroups.com>

Hi,

On 17/09/2015 at 21:07:19 -0700, Hao Nguyen wrote :
> We're working on our custom board running Linux kernel v2.6.37.
> 
> Our board uses CBC34803 chip cho real time function. Everything is ok 
> except a problem.
> The problem is when i change system time using "date" command with option 
> '-s', time doesn't automatically update to RTC CBC34803.
> My question:  which is responsible for update system time to rtc whenever 
> the system time changes?

hwclock is the tool you are looking for.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
