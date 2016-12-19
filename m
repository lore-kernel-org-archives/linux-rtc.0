Return-Path: <rtc-linux+bncBDJIP47K7MERBVWR4HBAKGQEMMTGDZI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com. [209.85.214.66])
        by gmr-mx.google.com with ESMTPS id j63si1705964ita.1.2016.12.19.15.10.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 15:10:14 -0800 (PST)
Received: by mail-it0-f66.google.com with SMTP id c20so12034345itb.0
        for <rtc-linux@googlegroups.com>; Mon, 19 Dec 2016 15:10:14 -0800 (PST)
Date: Mon, 19 Dec 2016 17:10:12 -0600
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Russell King <linux@armlinux.org.uk>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [rtc-linux] Re: [PATCHv2 2/8] dt-bindings: document the STM32 RTC bindings
Message-ID: <20161219231012.qkdtgfdshlpvjzli@rob-hp-laptop>
References: <1481878257-29163-1-git-send-email-amelie.delaunay@st.com>
 <1481878257-29163-3-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1481878257-29163-3-git-send-email-amelie.delaunay@st.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Dec 16, 2016 at 09:50:51AM +0100, Amelie Delaunay wrote:
> This patch adds documentation of device tree bindings for the STM32 RTC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt

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
