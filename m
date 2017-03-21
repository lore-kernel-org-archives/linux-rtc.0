Return-Path: <rtc-linux+bncBDVNLUMXTUCRBN6YYXDAKGQE5NP6SJA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x231.google.com (mail-lf0-x231.google.com. [2a00:1450:4010:c07::231])
        by gmr-mx.google.com with ESMTPS id i76si1378735wmh.1.2017.03.21.11.08.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2017 11:08:55 -0700 (PDT)
Received: by mail-lf0-x231.google.com with SMTP id j90so70275240lfk.2
        for <rtc-linux@googlegroups.com>; Tue, 21 Mar 2017 11:08:55 -0700 (PDT)
MIME-Version: 1.0
From: Tracy Smith <tlsmith3777@gmail.com>
Date: Tue, 21 Mar 2017 13:08:54 -0500
Message-ID: <CAChUvXMxreofSQqsv-+Pgq9uZPpJ24P0geUYes_6Lu8nCtsNGg@mail.gmail.com>
Subject: [rtc-linux] Question: Linux changes required for off control board RTC
To: Lee Jones <lee.jones@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	lkml <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi, not sure if this is the correct venue to post a question, so
please forgive and direct me to the correct board or list if not.

A custom board implementation using a ARM-8 Cortex A53 NXP LS1043ardb
is considering moving the RTC from the control board to an FPGA.
Reason is for accuracy of time/date and efficiency for their FPGA/DSP
application.

1) What kernel changes would be required to support such an
implementation and these would need to be pushed to the community
under the GPL?

2) Is it a trivial task to make such changes in the kernel to support
an RTC not located on the control board/SoC itself?

3) What is the expected behavior of the kernel with no changes added
to accommodate such an architecture?

4) Is there a configurable kernel option to allow for such a change,
or have these or similar changes already been added to the kernel?

thx,
Tracy

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
