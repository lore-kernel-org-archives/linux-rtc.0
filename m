Return-Path: <rtc-linux+bncBDJIP47K7MERBFOBWXFAKGQENIT4R4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com. [209.85.161.194])
        by gmr-mx.google.com with ESMTPS id o206si301576ywb.12.2017.06.23.11.40.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 11:40:21 -0700 (PDT)
Received: by mail-yw0-f194.google.com with SMTP id e142so3197097ywa.2
        for <rtc-linux@googlegroups.com>; Fri, 23 Jun 2017 11:40:21 -0700 (PDT)
Date: Fri, 23 Jun 2017 13:40:19 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH 1/2] dt-bindings: Document the Broadcom STB
 wake-up timer node
Message-ID: <20170623184019.ftptqodyv3bnkyz2@rob-hp-laptop>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
 <20170615195904.12653-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170615195904.12653-2-f.fainelli@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jun 15, 2017 at 12:59:03PM -0700, Florian Fainelli wrote:
> Document the binding for the Broadcom STB SoCs wake-up timer node
> allowing the system to generate alarms and exit low power states.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/rtc/brcm,brcmstb-waketimer.txt        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt

Acked-by: Rob Herring <robh@kernel.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
