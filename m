Return-Path: <rtc-linux+bncBDKZNNNLXAHBBB55W2WQKGQE53OIAUQ@googlegroups.com>
Received: from mail-qg0-x22a.google.com (mail-qg0-x22a.google.com. [2607:f8b0:400d:c04::22a])
        by gmr-mx.google.com with ESMTPS id b76si2023031ywe.1.2015.07.20.18.21.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 18:21:11 -0700 (PDT)
Received: by mail-qg0-x22a.google.com with SMTP id 5so81227069qgy.3
        for <rtc-linux@googlegroups.com>; Mon, 20 Jul 2015 18:21:11 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1437433372-15425-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
	<1437433372-15425-4-git-send-email-dmitry.torokhov@gmail.com>
Date: Tue, 21 Jul 2015 10:21:11 +0900
Message-ID: <CAJKOXPevQGGwCYgcH9zJ6b9c4u=XV6pO2tzne0Ub3uinDjLqvQ@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH 4/4] RTC: switch to using is_visible() to
 control sysfs attributes
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-07-21 8:02 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Instead of creating an attribute manually, after the device has been
> registered, let's rely on facilities provided by the attribute groups to
> control which attributes are visible and which are not. This allows to to
> create all needed attributes at once, at the same time that we register
> RTC class device.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/rtc/class.c     |  4 +--
>  drivers/rtc/rtc-core.h  | 19 ++-----------
>  drivers/rtc/rtc-sysfs.c | 75 +++++++++++++++++++++++++------------------------
>  3 files changed, 42 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index de7707f..de86578 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -202,6 +202,7 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
>         rtc->max_user_freq = 64;
>         rtc->dev.parent = dev;
>         rtc->dev.class = rtc_class;
> +       rtc->dev.groups = rtc_get_dev_attribute_groups();
>         rtc->dev.release = rtc_device_release;
>
>         mutex_init(&rtc->ops_lock);
> @@ -240,7 +241,6 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
>         }
>
>         rtc_dev_add_device(rtc);
> -       rtc_sysfs_add_device(rtc);
>         rtc_proc_add_device(rtc);
>
>         dev_info(dev, "rtc core: registered %s as %s\n",
> @@ -271,7 +271,6 @@ void rtc_device_unregister(struct rtc_device *rtc)
>          * Remove innards of this RTC, then disable it, before
>          * letting any rtc_class_open() users access it again
>          */
> -       rtc_sysfs_del_device(rtc);
>         rtc_dev_del_device(rtc);
>         rtc_proc_del_device(rtc);
>         device_del(&rtc->dev);
> @@ -360,7 +359,6 @@ static int __init rtc_init(void)
>         }
>         rtc_class->pm = RTC_CLASS_DEV_PM_OPS;
>         rtc_dev_init();
> -       rtc_sysfs_init(rtc_class);
>         return 0;
>  }
>
> diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
> index 5f9df74..a098aea 100644
> --- a/drivers/rtc/rtc-core.h
> +++ b/drivers/rtc/rtc-core.h
> @@ -48,23 +48,10 @@ static inline void rtc_proc_del_device(struct rtc_device *rtc)
>  #endif
>
>  #ifdef CONFIG_RTC_INTF_SYSFS
> -
> -extern void __init rtc_sysfs_init(struct class *);
> -extern void rtc_sysfs_add_device(struct rtc_device *rtc);
> -extern void rtc_sysfs_del_device(struct rtc_device *rtc);
> -
> +const struct attribute_group **rtc_get_dev_attribute_groups(void);
>  #else
> -
> -static inline void rtc_sysfs_init(struct class *rtc)
> -{
> -}
> -
> -static inline void rtc_sysfs_add_device(struct rtc_device *rtc)
> +static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
>  {
> +       return NULL;
>  }
> -
> -static inline void rtc_sysfs_del_device(struct rtc_device *rtc)
> -{
> -}
> -
>  #endif
> diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
> index babd43b..0b4366c 100644
> --- a/drivers/rtc/rtc-sysfs.c
> +++ b/drivers/rtc/rtc-sysfs.c
> @@ -122,20 +122,8 @@ hctosys_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(hctosys);
>
> -static struct attribute *rtc_attrs[] = {
> -       &dev_attr_name.attr,
> -       &dev_attr_date.attr,
> -       &dev_attr_time.attr,
> -       &dev_attr_since_epoch.attr,
> -       &dev_attr_max_user_freq.attr,
> -       &dev_attr_hctosys.attr,
> -       NULL,
> -};
> -ATTRIBUTE_GROUPS(rtc);
> -
>  static ssize_t
> -rtc_sysfs_show_wakealarm(struct device *dev, struct device_attribute *attr,
> -               char *buf)
> +wakealarm_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>         ssize_t retval;
>         unsigned long alarm;
> @@ -159,7 +147,7 @@ rtc_sysfs_show_wakealarm(struct device *dev, struct device_attribute *attr,
>  }
>
>  static ssize_t
> -rtc_sysfs_set_wakealarm(struct device *dev, struct device_attribute *attr,
> +wakealarm_store(struct device *dev, struct device_attribute *attr,
>                 const char *buf, size_t n)
>  {
>         ssize_t retval;
> @@ -221,45 +209,58 @@ rtc_sysfs_set_wakealarm(struct device *dev, struct device_attribute *attr,
>         retval = rtc_set_alarm(rtc, &alm);
>         return (retval < 0) ? retval : n;
>  }
> -static DEVICE_ATTR(wakealarm, S_IRUGO | S_IWUSR,
> -               rtc_sysfs_show_wakealarm, rtc_sysfs_set_wakealarm);
> +static DEVICE_ATTR_RW(wakealarm);

This and renaming of show/store functions look unrelated

>
> +static struct attribute *rtc_attrs[] = {
> +       &dev_attr_name.attr,
> +       &dev_attr_date.attr,
> +       &dev_attr_time.attr,
> +       &dev_attr_since_epoch.attr,
> +       &dev_attr_max_user_freq.attr,
> +       &dev_attr_hctosys.attr,
> +       &dev_attr_wakealarm.attr,
> +       NULL,
> +};
>
> -/* The reason to trigger an alarm with no process watching it (via sysfs)
> +/*
> + * The reason to trigger an alarm with no process watching it (via sysfs)
>   * is its side effect:  waking from a system state like suspend-to-RAM or
>   * suspend-to-disk.  So: no attribute unless that side effect is possible.
>   * (Userspace may disable that mechanism later.)
>   */
> -static inline int rtc_does_wakealarm(struct rtc_device *rtc)
> +static bool rtc_does_wakealarm(struct rtc_device *rtc)
>  {
>         if (!device_can_wakeup(rtc->dev.parent))
> -               return 0;
> +               return false;
> +
>         return rtc->ops->set_alarm != NULL;
>  }

This looks unrelated too and confuses me. Could you split such cleanup
from main goal of the patch?

Best regards,
Krzysztof

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
