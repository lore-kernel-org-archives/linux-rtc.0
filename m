Return-Path: <rtc-linux+bncBDEKVJM7XAHRBYOC764AKGQE5BKBRFY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.135])
        by gmr-mx.google.com with ESMTPS id a65si761242wma.0.2016.04.26.14.45.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2016 14:45:05 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tony.luck@intel.com,
	geert@linux-m68k.org,
	jejb@parisc-linux.org,
	deller@gmx.de,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au,
	dalias@libc.org,
	dhowells@redhat.com,
	yasutake.koichi@jp.panasonic.com,
	rth@twiddle.net,
	ink@jurassic.park.msu.ru,
	linux-alpha@vger.kernel.org,
	x86@kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-arch@vger.kernel.org
Subject: [rtc-linux] char: legacy RTC cleanups
Date: Tue, 26 Apr 2016 23:44:04 +0200
Message-Id: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

I've had these patches in my tree for a while, after the first one
had a few issues that are fixed in this new version. The old-style
PC RTC driver is now also disabled on m68k (as pointed out by
Geert), ppc (it was also blacklisted), and m32r (I showed that
it did not build).

For the genrtc driver, rearranging the headers makes it simpler
to use and reduces duplication. In case of alpha and mn10300,
I've shown that the genrtc and rtc drivers are doing the same
thing, so we don't need them both. The remaining three
architectures (m68k, parisc, powerpc) actually all support
the newer rtc-generic driver, so we could remove genrtc completely
if we want to.

	Arnd

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
