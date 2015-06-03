Return-Path: <rtc-linux+bncBCF252X47MMRBGUZXSVQKGQEQERRDYQ@googlegroups.com>
Received: from zabrina.hetzner-de.towertech.it (zabrina.hetzner-de.towertech.it. [178.63.16.19])
        by gmr-mx.google.com with ESMTP id ec7si69453wib.3.2015.06.03.07.18.02
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Jun 2015 07:18:02 -0700 (PDT)
Date: Wed, 3 Jun 2015 16:17:59 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, pang.xunlei@zte.com.cn, Andrew Christian
 <andrew.christian@hp.com>, CIH <cih@coventive.com>, John Stultz
 <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Nicolas Pitre
 <nico@fluxnic.net>, Xunlei Pang <pang.xunlei@linaro.org>, Richard Purdie
 <rpurdie@rpsys.net>, rtc-linux@googlegroups.com, Xunlei Pang
 <xlpang@126.com>
Subject: [rtc-linux] Re: [5/5] drivers/rtc/sa1100: Replace deprecated
 rtc_tm_to_time() and rtc_time_to_tm()
Message-ID: <20150603161759.014161cf@linux.lan.towertech.it>
In-Reply-To: <20150601195909.GO4710@piout.net>
References: <1429089611-29776-5-git-send-email-xlpang@126.com>
	<OF1F6D43BC.C38481A0-ON48257E54.004FA90B-48257E54.004FD9D8@LocalDomain>
	<OF8AF02B38.A9E97627-ON48257E55.00352B8F-48257E55.0037661B@zte.com.cn>
	<3404495.679z0IaaBp@wuerfel>
	<20150601195909.GO4710@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, 1 Jun 2015 21:59:09 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> I feel that we still have a bit of time before having to hurry and find
> a proper solution ;)

 agreed :)

-- 

 Best regards,

 Alessandro Zummo - CEO,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

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
