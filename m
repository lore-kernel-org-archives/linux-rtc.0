Date: Thu, 11 Aug 2016 23:13:33 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: danielromell@gmail.com
Cc: rtc-linux <rtc-linux@googlegroups.com>, a.zummo@towertech.it,
	linux-kernel@vger.kernel.org, daro@hms.se, jao@hms.se, mago@hms.se
Subject: Re: [rtc-linux] Re: [PATCH v2 1/2] rtc: bq32k: Use correct mask name
 for 'minutes' register.
Message-ID: <20160811211333.GL8132@piout.net>
References: <1470909555-9226-1-git-send-email-daro@hms.se>
 <1470915104-10683-2-git-send-email-daro@hms.se>
 <20160811134257.GH8132@piout.net>
 <5b6636b7-ff29-458b-b566-4b97e401b794@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5b6636b7-ff29-458b-b566-4b97e401b794@googlegroups.com>
List-ID: <rtc-linux.googlegroups.com>

On 11/08/2016 at 07:56:03 -0700, danielromell@gmail.com wrote :
> 
> 
> Den torsdag 11 augusti 2016 kl. 15:42:58 UTC+2 skrev alexandre.belloni:
> >
> > On 11/08/2016 at 13:31:43 +0200, Daniel Romell wrote : 
> > > From: Jan Östlund <j...@hms.se <javascript:>> 
> > > 
> > > The BQ32K_SECONDS_MASK and BQ32K_MINUTES_MASK both has the same 
> > > value. This is no functional change. 
> > > 
> > > Signed-off-by: Daniel Romell <da...@hms.se <javascript:>> 
> >
> > Sorry, I saw it only before trying apply but both patches also need Jan's 
> > SoB. 
> >
> 
> Ah, sorry, my bad. I'll ask him to add that. 
> Is it ok if he just reply to the emails with his SoB line, or do you need a 
> new patch set?  
> 

That's a bit unconventional but I'm fine with a simple mail.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
