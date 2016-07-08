Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBUHI725QKGQEPNMSNVI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a6si176866wma.1.2016.07.08.07.10.24
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Jul 2016 07:10:24 -0700 (PDT)
Date: Fri, 8 Jul 2016 16:10:23 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: rtc-palmas: correct for bcd year
Message-ID: <20160708141023.GH22202@piout.net>
References: <1451508726-31769-1-git-send-email-salyzyn@android.com>
 <20160104161853.GC32724@piout.net>
 <568AA1C2.2070407@android.com>
 <20160105000000.GE32724@piout.net>
 <568BEA92.2090701@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <568BEA92.2090701@android.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/01/2016 at 08:08:50 -0800, Mark Salyzyn wrote :
> On 01/04/2016 04:00 PM, Alexandre Belloni wrote:
> > I'd say that the proper course of action is to refuse to set dates
> > before 2000 and after 2100. See
> > http://patchwork.ozlabs.org/patch/541037/
> Got it.
> 
> We have an issue though, Android (or rather any embedded) devices must
> continue to function when date is manually set to any value between 1970 and
> 2037. The issue here is a fresh device with a recently charged battery will
> _start_ at 1970 until ntp or cell time/date/locale is set and the device
> must continue to function in this vacuum. A device reboot should not result
> in the other calendar values being reset, should the year be wrong, as this
> will result in a bad user experience.
> 
> We will have to use a different patch on Android than upstream if dates
> before 2000 are deprecated.
> 
> All other factors (rollover, leap) can be corrected by frameworks and
> runtime since the rtc is generally secondary (ie: first rtc driver was in
> 1979, created a daemon to correct the flaws in the hardware clock using a
> cron job)
> 

Well, I was still thinking about that issue but while handling properly
a gap in the RTC continuity is impossible, it is actually easy to handle
an offset in the RTC by using mktime and then offseting the resulting
time_t. Of course you'll then need to handle leap years and the likes
but you said that was not an issue for you.

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
