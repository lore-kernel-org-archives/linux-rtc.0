Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6E45PGAKGQENB35JRQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id c135si47994wmd.3.2017.08.21.05.13.44
        for <rtc-linux@googlegroups.com>;
        Mon, 21 Aug 2017 05:13:44 -0700 (PDT)
Date: Mon, 21 Aug 2017 14:13:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>,
	John Stultz <john.stultz@linaro.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Subject: Re: [rtc-linux] RTC used as a module
Message-ID: <20170821121344.emzboqji3hhakzpf@piout.net>
References: <20170223121426.i24ssrlwitrvb32h@piout.net>
 <232e7023-4571-3a91-2366-753a1479c52a@monstr.eu>
 <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
 <CALAqxLUWD23LWh3z8sr_hFMvrf+SmVOH-i6VHDr60uQZRyWXbA@mail.gmail.com>
 <cd325ab6-b31c-a03f-2bd3-e2e8cb99a6a5@xilinx.com>
 <8f181912-d6b1-fe2b-92ef-df2cb26f3f02@xilinx.com>
 <cc3a8f33-1d68-2ad1-6aba-773f53c29d61@xilinx.com>
 <59e7661e-7e1f-a11e-93c2-9a4bbe9ebe1a@xilinx.com>
 <20170820220329.uzx3ryehq75qruwz@piout.net>
 <44ce48f1-73bb-1b88-1e92-327e80f09f96@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <44ce48f1-73bb-1b88-1e92-327e80f09f96@monstr.eu>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/08/2017 at 12:50:34 +0200, Michal Simek wrote:
> Hi,
> 
> On 21.8.2017 00:03, Alexandre Belloni wrote:
> > Hi Michal,
> > 
> > I've just send a patch to fix this issue (and avoid your other patch).
> > 
> > Could you test it? (I did test on an atmel platform)
> > 
> > Sorry it took so long!
> 
> not a problem but it looks like it is still just temporary solution. I
> would expect that you can't unload module when this alarm is used. It if
> it is not used then you should be able to remove it.
> 

Yes, the alarmtimer handling needs to be made more flexible, especially
in the rtc device selection.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
