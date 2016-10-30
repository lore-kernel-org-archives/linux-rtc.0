Return-Path: <rtc-linux+bncBCF2PQPV4MDRBRFC27AAKGQEHB335PI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com. [2607:f8b0:4001:c0b::232])
        by gmr-mx.google.com with ESMTPS id j198si1253056itb.0.2016.10.30.03.53.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2016 03:53:56 -0700 (PDT)
Received: by mail-it0-x232.google.com with SMTP id f129so8854905itc.1
        for <rtc-linux@googlegroups.com>; Sun, 30 Oct 2016 03:53:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1477814586-4795-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1477814586-4795-1-git-send-email-venkat.prashanth2498@gmail.com>
From: Joachim  Eastwood <manabian@gmail.com>
Date: Sun, 30 Oct 2016 11:53:55 +0100
Message-ID: <CAGhQ9VxhhU23n5V=ONfU4aXUfRqsjcvj2sa5xnOqSqGz4StM-w@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: add support for rtc NXP pca8565
To: VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Venkat,

On 30 October 2016 at 09:03, VENKAT PRASHANTH B U
<venkat.prashanth2498@gmail.com> wrote:
> This is a patch to add support for
> NXP rtc pca8565

>From a quick look the PCA8565 register layout looks very similar to
PCF8563 which already has a driver (rtc-pcf8563).

Can you use that driver instead of creating a new one? If so; send a
patch for rtc-pcf8563 that adds "pca8565" to the set of i2c ids.


regards,
Joachim Eastwood

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
