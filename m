Return-Path: <rtc-linux+bncBDKJVFPCVIJBB5P5THAAKGQERGEBLYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx3-phx2.redhat.com (mx3-phx2.redhat.com. [209.132.183.24])
        by gmr-mx.google.com with ESMTPS id o13si326917itc.3.2016.10.18.12.58.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 18 Oct 2016 12:58:45 -0700 (PDT)
Date: Tue, 18 Oct 2016 15:58:41 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rtc-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1380748808.370638.1476820721453.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161018192014.sqekbhk66b5ne7jy@piout.net>
References: <2061831780.279821.1476797292640.JavaMail.zimbra@redhat.com> <1882425827.361582.1476816475343.JavaMail.zimbra@redhat.com> <20161018192014.sqekbhk66b5ne7jy@piout.net>
Subject: [rtc-linux] Re: [4.9-rc1] kernel panic from `cat /proc/driver/rtc`
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


> Is that fixed by http://patchwork.ozlabs.org/patch/683728/ ?
Yup.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
