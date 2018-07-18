Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33421 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbeGRNZn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Jul 2018 09:25:43 -0400
MIME-Version: 1.0
In-Reply-To: <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com> <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 18 Jul 2018 15:47:54 +0300
Message-ID: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Jul 18, 2018 at 12:40 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> On m41txx you can enable open-drain OUT pin to check if offset is ok.
> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
> 512 times faster than 1s tick base.
>
> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.

> +static ssize_t frequency_test_enable_store(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          const char *buf, size_t count)
> +{
> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);


> +       bool freq_test_en = 0;

First of all, initialization of boolean using int is not very best style.
Second, this is not needed.

> +       int ret;
> +
> +       ret = kstrtobool(buf, &freq_test_en);

> +       if (ret == -EINVAL) {

What kind of other error code you may expect and why they are not
considered as no error?

> +               dev_err(dev, "Failed to store RTC Frequency Test attribute\n");
> +               return ret;
> +       }
> +
> +       regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL, M41TXX_BIT_FT,
> +                          freq_test_en ? M41TXX_BIT_FT : 0);
> +
> +       return count;
> +}
> +
> +static ssize_t frequency_test_enable_show(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         char *buf)
> +{
> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +       unsigned int ctrl_reg;
> +
> +       regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
> +

> +       if (ctrl_reg & M41TXX_BIT_FT)
> +               return scnprintf(buf, PAGE_SIZE, "on\n");
> +       else
> +               return scnprintf(buf, PAGE_SIZE, "off\n");

Entire condition might be one line.

> +}
> +

> +static int ds1307_add_frequency_test(struct ds1307 *ds1307)
> +{

> +       int err = 0;

Redundant assignment. See below.

> +
> +       switch (ds1307->type) {
> +       case m41t0:
> +       case m41t00:
> +       case m41t11:
> +               /* Export sysfs entries */
> +               err = sysfs_create_group(&(ds1307->dev)->kobj,
> +                                        &rtc_freq_test_attr_group);
> +               if (err) {
> +                       dev_err(ds1307->dev,
> +                               "Failed to create sysfs group: %d\n",
> +                               err);
> +                       return err;
> +               }
> +
> +               err = devm_add_action_or_reset(ds1307->dev,
> +                                              rtc_calib_remove_sysfs_group,
> +                                              ds1307->dev);
> +               if (err) {
> +                       dev_err(ds1307->dev,
> +                               "Failed to add sysfs cleanup action: %d\n",
> +                               err);
> +                       sysfs_remove_group(&(ds1307->dev)->kobj,
> +                                          &rtc_freq_test_attr_group);
> +                       return err;
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +

> +       return err;

return 0;

-- 
With Best Regards,
Andy Shevchenko
