Return-Path: <rtc-linux+bncBDX5ZRH7XQGRBYFD765QKGQEAV5OGJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com. [2607:f8b0:400e:c03::22b])
        by gmr-mx.google.com with ESMTPS id c11si572134pfc.2.2016.07.08.09.16.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 09:16:32 -0700 (PDT)
Received: by mail-pa0-x22b.google.com with SMTP id dx3so13451039pab.2
        for <rtc-linux@googlegroups.com>; Fri, 08 Jul 2016 09:16:32 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk,  linux-amlogic@lists.infradead.org,  rtc-linux@googlegroups.com,  a.zummo@towertech.it,  alexandre.belloni@free-electrons.com,  devicetree@vger.kernel.org,  narmstrong@baylibre.com,  frowand.list@gmail.com
Subject: [rtc-linux] Re: [PATCH v3 1/4] rtc: support for amlogic meson rtc
References: <1467748122-14833-1-git-send-email-ben.dooks@codethink.co.uk>
	<1467748122-14833-3-git-send-email-ben.dooks@codethink.co.uk>
Date: Fri, 08 Jul 2016 09:16:30 -0700
In-Reply-To: <1467748122-14833-3-git-send-email-ben.dooks@codethink.co.uk>
	(Ben Dooks's message of "Tue, 5 Jul 2016 20:48:41 +0100")
Message-ID: <7hoa6885r5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Ben Dooks <ben.dooks@codethink.co.uk> writes:

> Add support for the AMLogic meson8b/meson6 RTC block.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Tested-by: Kevin Hilman <khilman@baylibre.com>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
