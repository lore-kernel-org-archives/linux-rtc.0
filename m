Return-Path: <rtc-linux+bncBDE6RCFOWIARBEURUXFAKGQEDXR426Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com. [2607:f8b0:4001:c06::230])
        by gmr-mx.google.com with ESMTPS id 81si1267167ith.1.2017.06.20.09.08.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 09:08:49 -0700 (PDT)
Received: by mail-io0-x230.google.com with SMTP id t87so87606106ioe.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 09:08:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497951359-13334-35-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org> <1497951359-13334-35-git-send-email-benjamin.gaignard@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Jun 2017 18:08:48 +0200
Message-ID: <CACRpkdZsdwuytW5RHSdd5t9MSyYnhV1nNNKOR1VUzqEgicFqUw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 34/51] rtc: pl031: stop using rtc deprecated functions
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linaro-kernel <linaro-kernel@lists.linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 20, 2017 at 11:35 AM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:

> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> rely on 32bits variables and that will make rtc break in y2038/2016.
> Stop using those two functions to safer 64bits ones.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Alessandro Zummo <a.zummo@towertech.it>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: rtc-linux@googlegroups.com
> CC: linux-kernel@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
