Return-Path: <rtc-linux+bncBCLLTU5HV4PRBTO77W6AKGQECPWH6BY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mta2.parkeon.com (ip83.parkeon.com. [213.152.31.83])
        by gmr-mx.google.com with ESMTPS id w64si933824wmf.3.2016.08.01.08.50.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 08:50:37 -0700 (PDT)
Subject: [rtc-linux] [PATCH  0/3] rtc: Add pcf85263
To: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: devicetree@vger.kernel.org, rtc-linux@googlegroups.com
Date: Mon, 01 Aug 2016 17:50:30 +0200
Message-ID: <20160801155029.32232.56063.stgit@localhost>
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

This series adds support for the NXP PCF85263 RTC Chip.

3 patches instead of 1 to:
	* Seperate the DT binding
	* Seperate the "unconventional" century support

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
