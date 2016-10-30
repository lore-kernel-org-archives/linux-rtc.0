Return-Path: <rtc-linux+bncBC433LF43MBBBJHY3HAAKGQELRAS7PY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from outils.crapouillou.net (outils.crapouillou.net. [89.234.176.41])
        by gmr-mx.google.com with ESMTPS id d64si569819wmh.2.2016.10.30.16.02.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2016 16:02:59 -0700 (PDT)
From: Paul Cercueil <paul@crapouillou.net>
To: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: [rtc-linux] [PATCH v2 0/7] DT bindings for the jz4740-rtc driver
Date: Mon, 31 Oct 2016 00:02:40 +0100
Message-Id: <20161030230247.20538-1-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch set is a v2 of a patchset I sent in March.

The previous patch 5/5 was garbage and has been dropped.
It was garbage, for two reasons:
- It enforced the jz4740-rtc as the system power controller in the
  SoC devicetree file, which introduced policy (maybe the jz4740-based
  boards want to use something else as the system power controller)
- It added the 'system-power-controller' entry not to the jz4740-rtc driver
  node, but to the 'rtc' clock node... I don't know how that slipped in, but
  I apologise for that. I need to raise my QA standards.

For the rest:

1/7: No change

2/7:
- Remove 'interrupt-parent' of the list of required properties
- Add the -msec suffix for the DT entries that represent time

3/7: No change

4/7:
- Get a handle to the 'rtc' clock in the probe function, to handle errors early
- Call clk_prepare_enable() on the 'rtc' clock before calling clk_get_rate()
- Use the -msec suffix for the OF properties that deal with time
- Use of_property_read_32() instead of device_property_read_u32()

5/7, 6/7, 7/7: New patches

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
