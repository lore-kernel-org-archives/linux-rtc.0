Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBEOGQLDAKGQEY77PQYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id b186si1921876wme.1.2017.03.08.16.34.24
        for <rtc-linux@googlegroups.com>;
        Wed, 08 Mar 2017 16:34:24 -0800 (PST)
Date: Thu, 9 Mar 2017 01:34:24 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv4 2/2] rtc: cpcap: new rtc driver
Message-ID: <20170309003424.uj5t4b7wfsbqf2e2@piout.net>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170302002709.22276-1-sre@kernel.org>
 <20170302002709.22276-2-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170302002709.22276-2-sre@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/03/2017 at 01:27:09 +0100, Sebastian Reichel wrote:
> This driver supports the Motorola CPCAP PMIC found on
> some of Motorola's mobile phones, such as the Droid 4.
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv3:
>  - Modified DT binding document to mention parent device
> ---
>  .../devicetree/bindings/rtc/cpcap-rtc.txt          |  18 ++
>  drivers/rtc/Kconfig                                |   7 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-cpcap.c                            | 332 +++++++++++++++++++++
>  4 files changed, 358 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
>  create mode 100644 drivers/rtc/rtc-cpcap.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
