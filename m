Return-Path: <rtc-linux+bncBCOML4NU3EDRBN5HUW2AKGQEVDJK2XQ@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.15.3])
        by gmr-mx.google.com with ESMTPS id 185si2344394wmn.0.2016.01.03.09.00.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 09:00:39 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 7/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in _abb5zes3_rtc_interrupt()
To: Julia Lawall <julia.lawall@lip6.fr>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688DF2D.6090204@users.sourceforge.net>
 <5688E229.4010400@users.sourceforge.net>
 <alpine.DEB.2.02.1601031348350.2053@localhost6.localdomain6>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <568953B2.6010402@users.sourceforge.net>
Date: Sun, 3 Jan 2016 18:00:34 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1601031348350.2053@localhost6.localdomain6>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

>> Pass the address of the data structure element "time" directly in calls
>> of the function "rtc_update_irq" instead of an extra initialisation
>> for one local variable at the beginning.
> 
> Also, I don't see anything related to time in this patch.

I should have referred to the data structure element "rtc" here.
Should I resend this patch series with a corrected commit message now?

Regards,
Markus

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
