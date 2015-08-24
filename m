Return-Path: <rtc-linux+bncBDS7HNEFSALRBDWQ5OXAKGQEYFDZ37Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id et8si59573wib.2.2015.08.24.02.46.53
        for <rtc-linux@googlegroups.com>;
        Mon, 24 Aug 2015 02:46:53 -0700 (PDT)
Date: Mon, 24 Aug 2015 11:45:02 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Suneel Garapati <suneel.garapati@xilinx.com>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, sorenb@xilinx.com,
	Alessandro Zummo <a.zummo@towertech.it>, punnaia@xilinx.com,
	anuragku@xilinx.com, anirudh@xilinx.com
Subject: [rtc-linux] Re: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
Message-ID: <20150824094502.GI13155@piout.net>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <20150824074310.GF13155@piout.net>
 <55DACC5A.80707@xilinx.com>
 <20150824080800.GG13155@piout.net>
 <55DAE15B.6090602@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55DAE15B.6090602@xilinx.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 24/08/2015 at 11:18:19 +0200, Michal Simek wrote :
> > I'm not fond of carrying patches with uncontactable authors. Is that a
> > permanent error?
>=20
> Unfortunately. That guy left Xilinx last week but don't be scared that
> none will be responsible about this driver. I have well proven history
> on Linux and others project and I am here if you need to do some testing
> or ACK for changes. Just let me know when you need something.
>=20
> get_maintainer returns me and Soren that's why you shouldn't have any
> problem with it.
>=20
> [linux]$ ./scripts/get_maintainer.pl -f drivers/rtc/rtc-zynqmp.c
> Alessandro Zummo <a.zummo@towertech.it> (maintainer:REAL TIME CLOCK
> (RTC) SUBSYSTEM)
> Alexandre Belloni <alexandre.belloni@free-electrons.com>
> (maintainer:REAL TIME CLOCK (RTC) SUBSYSTEM)
> Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ ARCHITECTURE)
> "S=C3=B6ren Brinkmann" <soren.brinkmann@xilinx.com> (reviewer)
> rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTUR=
E)
> linux-kernel@vger.kernel.org (open list)
>=20

Perfect, thanks!


--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
