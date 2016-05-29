Return-Path: <rtc-linux+bncBDS7HNEFSALRBOP2VW5AKGQEMR5NR2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id l68si1023093wmd.3.2016.05.29.16.37.29
        for <rtc-linux@googlegroups.com>;
        Sun, 29 May 2016 16:37:29 -0700 (PDT)
Date: Mon, 30 May 2016 01:37:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org,
	mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com,
	linux-alpha@vger.kernel.org, a.zummo@towertech.it,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
	linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [rtc-linux] Re: [PATCH v3 00/16] genrtc removal
Message-ID: <20160529233728.GP3451@piout.net>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <20160503072418.GA2335@piout.net>
 <3351574.jQ0612lD2O@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <3351574.jQ0612lD2O@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 03/05/2016 at 12:05:34 +0200, Arnd Bergmann wrote :
> On Tuesday 03 May 2016 09:24:18 Alexandre Belloni wrote:
> > Hi Arnd,
> > 
> > I see you didn't copy Greg on that series (that may explain his
> > confusion on the previous patch), do you expect me to take it
> > through the RTC tree? That is fine but I'd like some acks from him.
> 
> Yes, that was a mistake. I dropped Greg from one Cc list in v2 when
> I split up the RTC changes into the part that was for drivers/rtc
> and the other one for Greg's char-misc tree. Then I reused the first
> Cc list when I sent a combined series for v3 again. I'll fix that
> when I post v4. There are only very small changes in there that
> I still need to pick up, so hopefully that will be the last version.
> 
> It would be nice if you could take it through your tree then.
> 

We are now at 4.7-rc1. Can you send v4 soon so that I can apply that
series  and get it in linux-next?

There is a small rebase to do on patch v3.

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
