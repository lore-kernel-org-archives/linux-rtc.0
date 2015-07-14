Return-Path: <rtc-linux+bncBDULZYNR2QMRBWUSSSWQKGQERPITYXI@googlegroups.com>
Received: from mail-lb0-x230.google.com (mail-lb0-x230.google.com. [2a00:1450:4010:c04::230])
        by gmr-mx.google.com with ESMTPS id sf5si30828lbb.2.2015.07.14.06.06.34
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:06:34 -0700 (PDT)
Received: by mail-lb0-x230.google.com with SMTP id zr7so5661383lbb.1
        for <rtc-linux@googlegroups.com>; Tue, 14 Jul 2015 06:06:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150704190221.GB5497@piout.net>
References: <1436034454-10473-1-git-send-email-festevam@gmail.com>
	<20150704184216.GA5497@piout.net>
	<55982BF4.3020303@free-electrons.com>
	<20150704190221.GB5497@piout.net>
Date: Tue, 14 Jul 2015 10:06:34 -0300
Message-ID: <CAOMZO5AHxoRHE9GZH+wG0TmvV4t4jOhx8ywa541QJV_AteYbzw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] drivers/rtc/rtc-armada38x: Remove unused
 variable from armada38x_rtc_set_time()
From: Fabio Estevam <festevam@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@freescale.com>
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

On Sat, Jul 4, 2015 at 4:02 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

>
> Hum, okay, I just realized f98b733e93e00365b4df78fbb33c2cad3080f6bb is not fixing it...

Yes, the build warning is still present in linux-next.

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
