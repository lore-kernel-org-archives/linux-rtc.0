Return-Path: <rtc-linux+bncBCF2PQPV4MDRB5FK27AAKGQEIXBKWUY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com. [2607:f8b0:4001:c0b::244])
        by gmr-mx.google.com with ESMTPS id c34si1031963itd.1.2016.10.30.04.11.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2016 04:11:48 -0700 (PDT)
Received: by mail-it0-x244.google.com with SMTP id f129so3414783itc.2
        for <rtc-linux@googlegroups.com>; Sun, 30 Oct 2016 04:11:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1476898864-7004-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1476898864-7004-1-git-send-email-venkat.prashanth2498@gmail.com>
From: Joachim  Eastwood <manabian@gmail.com>
Date: Sun, 30 Oct 2016 12:11:47 +0100
Message-ID: <CAGhQ9VyWpGq1nKVBLX0AcKkGU8teH6rVjTc749uvdW9LmX_5gQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2] rtc: add support for rtc NXP pca21125
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

On 19 October 2016 at 19:41, VENKAT PRASHANTH B U
<venkat.prashanth2498@gmail.com> wrote:
> This is a patch to add support for
> NXP rtc pca21125

The register layout PCA21125 looks similar to PCF8563 which already
has a driver.

Would it be possible to support the PCA21125 device with the rtc-pcf8563 driver?
You will need to add a regmap layer since the PCA21125 is SPI while
the PCF8563 is I2C.


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
