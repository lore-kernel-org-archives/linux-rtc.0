Return-Path: <rtc-linux+bncBDA7X7F2WUEBBPMR4TDAKGQEROMDRRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x236.google.com (mail-wr0-x236.google.com. [2a00:1450:400c:c0c::236])
        by gmr-mx.google.com with ESMTPS id 82si19206wmg.3.2017.03.27.05.42.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2017 05:42:37 -0700 (PDT)
Received: by mail-wr0-x236.google.com with SMTP id u1so51729495wra.2
        for <rtc-linux@googlegroups.com>; Mon, 27 Mar 2017 05:42:37 -0700 (PDT)
Date: Mon, 27 Mar 2017 13:42:33 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Olof Johansson <olof@lixom.net>, bleung@chromium.org,
	martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 4/7] mfd: cros_ec: Get rid of
 cros_ec_check_features from cros_ec_dev.
Message-ID: <20170327124233.te32ebtunfo4qkds@dell>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-5-enric.balletbo@collabora.com>
 <8503bbd4-85b6-9a46-8ada-84e7332162d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <8503bbd4-85b6-9a46-8ada-84e7332162d8@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, 25 Mar 2017, Jonathan Cameron wrote:

> On 24/03/17 17:44, Enric Balletbo i Serra wrote:
> > The cros_ec_dev driver should be used only to expose the Chrome OS Embe=
dded
> > Controller to user-space and should not be used to add MFD devices by
> > calling mfd_add_devices. This patch moves this logic to the MFD cros_ec
> > driver and removes the MFD bits from the character device driver. Also
> > makes independent the IIO driver from the character device as also has =
no
> > sense.
> >=20
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Few trivial bits inline, but more comments than anything that needs
> changing.
>=20
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>=20
> Lee, so who gets to do the immutable branch for this one?

I have no strong opinion.

> > ---
> >=20
> >   As pointed by Lee Jones in this thread [1] we should not use the MFD =
API
> > outside of MFD. For this reason the cros-ec-rtc did not get accepted ye=
t.
> > The reality is that we are calling mfd_add_devices from cros-ec-dev dri=
ver
> > already, so this patch get rid off the MFD calls inside the chardev dri=
ver
> > and moves to cros-ec MFD. Also I think the chardev device should simply
> > implement the ioctl calls to access to it from userspace.
> >=20
> > [1]  https://www.spinics.net/lists/kernel/msg2465099.html
> >=20
> >  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   8 -
> >  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   8 +-
> >  drivers/iio/light/cros_ec_light_prox.c             |   8 -
> >  drivers/iio/pressure/cros_ec_baro.c                |   8 -
> >  drivers/mfd/cros_ec.c                              | 160 +++++++++++++=
+++++++
> >  drivers/platform/chrome/cros_ec_dev.c              | 161 -------------=
--------
> >  include/linux/mfd/cros_ec.h                        |   6 +-
> >  7 files changed, 170 insertions(+), 189 deletions(-)
> >=20
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/dri=
vers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > index 38e8783..9b53a01 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > @@ -191,19 +191,11 @@ static const struct iio_info ec_sensors_info =3D =
{
> >  static int cros_ec_sensors_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> > -	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> > -	struct cros_ec_device *ec_device;
> >  	struct iio_dev *indio_dev;
> >  	struct cros_ec_sensors_state *state;
> >  	struct iio_chan_spec *channel;
> >  	int ret, i;
> > =20
> > -	if (!ec_dev || !ec_dev->ec_dev) {
> > -		dev_warn(&pdev->dev, "No CROS EC device found.\n");
> > -		return -EINVAL;
> > -	}
> > -	ec_device =3D ec_dev->ec_dev;
> > -
> Huh, not sure why this hasn't been throwing warnings as ec_device is
> never used for anything.  Ah well, good to clean it up ;)
>=20
> >  	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*state));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c =
b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 416cae5..0cdb64a 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -41,12 +41,13 @@ int cros_ec_sensors_core_init(struct platform_devic=
e *pdev,
> >  {
> >  	struct device *dev =3D &pdev->dev;
> >  	struct cros_ec_sensors_core_state *state =3D iio_priv(indio_dev);
> > -	struct cros_ec_dev *ec =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct cros_ec_device *ec_dev =3D dev_get_drvdata(pdev->dev.parent);
> >  	struct cros_ec_sensor_platform *sensor_platform =3D dev_get_platdata(=
dev);
> > =20
> >  	platform_set_drvdata(pdev, indio_dev);
> > =20
> > -	state->ec =3D ec->ec_dev;
> > +	state->ec =3D ec_dev;
> > +
> If really going for the nitpick. Blank line doesn't really add anything..=
.
> >  	state->msg =3D devm_kzalloc(&pdev->dev,
> >  				max((u16)sizeof(struct ec_params_motion_sense),
> >  				state->ec->max_response), GFP_KERNEL);
> > @@ -59,7 +60,8 @@ int cros_ec_sensors_core_init(struct platform_device =
*pdev,
> > =20
> >  	/* Set up the host command structure. */
> >  	state->msg->version =3D 2;
> > -	state->msg->command =3D EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> > +	state->msg->command =3D EC_CMD_MOTION_SENSE_CMD +
> > +				sensor_platform->cmd_offset;
> >  	state->msg->outsize =3D sizeof(struct ec_params_motion_sense);
> > =20
> >  	indio_dev->dev.parent =3D &pdev->dev;
> > diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light=
/cros_ec_light_prox.c
> > index 7217223..2133ddc 100644
> > --- a/drivers/iio/light/cros_ec_light_prox.c
> > +++ b/drivers/iio/light/cros_ec_light_prox.c
> > @@ -181,19 +181,11 @@ static const struct iio_info cros_ec_light_prox_i=
nfo =3D {
> >  static int cros_ec_light_prox_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> > -	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> > -	struct cros_ec_device *ec_device;
> >  	struct iio_dev *indio_dev;
> >  	struct cros_ec_light_prox_state *state;
> >  	struct iio_chan_spec *channel;
> >  	int ret;
> > =20
> > -	if (!ec_dev || !ec_dev->ec_dev) {
> > -		dev_warn(dev, "No CROS EC device found.\n");
> > -		return -EINVAL;
> > -	}
> > -	ec_device =3D ec_dev->ec_dev;
> > -
> >  	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*state));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure=
/cros_ec_baro.c
> > index 48b2a30..dbea18b 100644
> > --- a/drivers/iio/pressure/cros_ec_baro.c
> > +++ b/drivers/iio/pressure/cros_ec_baro.c
> > @@ -126,19 +126,11 @@ static const struct iio_info cros_ec_baro_info =
=3D {
> >  static int cros_ec_baro_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> > -	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> > -	struct cros_ec_device *ec_device;
> >  	struct iio_dev *indio_dev;
> >  	struct cros_ec_baro_state *state;
> >  	struct iio_chan_spec *channel;
> >  	int ret;
> > =20
> > -	if (!ec_dev || !ec_dev->ec_dev) {
> > -		dev_warn(dev, "No CROS EC device found.\n");
> > -		return -EINVAL;
> > -	}
> > -	ec_device =3D ec_dev->ec_dev;
> > -
> >  	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*state));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index d4a407e..bbc17ab 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -84,6 +84,160 @@ static int cros_ec_sleep_event(struct cros_ec_devic=
e *ec_dev, u8 sleep_event)
> >  	return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> >  }
> > =20
> > +static int cros_ec_check_features(struct cros_ec_device *ec_dev, int f=
eature)
> > +{
> Fair enough on the parameter rename. Slightly better this way...
> Absolute ideal would have been a separate rename patch then this one, but
> this is fine...
> > +	struct cros_ec_command *msg;
> > +	int ret;
> > +
> > +	if (ec_dev->features[0] =3D=3D -1U && ec_dev->features[1] =3D=3D -1U)=
 {
> > +		/* features bitmap not read yet */
> > +
> > +		msg =3D kmalloc(sizeof(*msg) + sizeof(ec_dev->features),
> > +			      GFP_KERNEL);
> > +		if (!msg)
> > +			return -ENOMEM;
> > +
> > +		msg->version =3D 0;
> > +		msg->command =3D EC_CMD_GET_FEATURES + ec_p.cmd_offset;
> > +		msg->insize =3D sizeof(ec_dev->features);
> > +		msg->outsize =3D 0;
> > +
> > +		ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> > +		if (ret < 0 || msg->result !=3D EC_RES_SUCCESS) {
> > +			dev_warn(ec_dev->dev, "cannot get EC features: %d/%d\n",
> > +				 ret, msg->result);
> > +			memset(ec_dev->features, 0, sizeof(ec_dev->features));
> > +		}
> > +
> > +		memcpy(ec_dev->features, msg->data, sizeof(ec_dev->features));
> > +
> > +		dev_dbg(ec_dev->dev, "EC features %08x %08x\n",
> > +			ec_dev->features[0], ec_dev->features[1]);
> > +
> > +		kfree(msg);
> > +	}
> > +
> > +	return ec_dev->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> > +}
> > +
> > +static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
> > +{
> > +	/*
> > +	 * Issue a command to get the number of sensor reported.
> > +	 * Build an array of sensors driver and register them all.
> > +	 */
> > +	int ret, i, id, sensor_num;
> > +	struct mfd_cell *sensor_cells;
> > +	struct cros_ec_sensor_platform *sensor_platforms;
> > +	int sensor_type[MOTIONSENSE_TYPE_MAX];
> > +	struct ec_params_motion_sense *params;
> > +	struct ec_response_motion_sense *resp;
> > +	struct cros_ec_command *msg;
> > +
> > +	msg =3D kzalloc(sizeof(struct cros_ec_command) +
> > +		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> > +	if (msg =3D=3D NULL)
> > +		return;
> > +
> > +	msg->version =3D 2;
> > +	msg->command =3D EC_CMD_MOTION_SENSE_CMD + ec_p.cmd_offset;
> > +	msg->outsize =3D sizeof(*params);
> > +	msg->insize =3D sizeof(*resp);
> > +
> > +	params =3D (struct ec_params_motion_sense *)msg->data;
> > +	params->cmd =3D MOTIONSENSE_CMD_DUMP;
> > +
> > +	ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> > +	if (ret < 0 || msg->result !=3D EC_RES_SUCCESS) {
> > +		dev_warn(ec_dev->dev, "cannot get EC sensor information: %d/%d\n",
> > +			 ret, msg->result);
> > +		goto error;
> > +	}
> > +
> > +	resp =3D (struct ec_response_motion_sense *)msg->data;
> > +	sensor_num =3D resp->dump.sensor_count;
> > +	/* Allocate 2 extra sensors in case lid angle or FIFO are needed */
> > +	sensor_cells =3D kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
> > +			       GFP_KERNEL);
> > +	if (sensor_cells =3D=3D NULL)
> > +		goto error;
> > +
> > +	sensor_platforms =3D kzalloc(sizeof(struct cros_ec_sensor_platform) *
> > +		  (sensor_num + 1), GFP_KERNEL);
> > +	if (sensor_platforms =3D=3D NULL)
> > +		goto error_platforms;
> > +
> > +	memset(sensor_type, 0, sizeof(sensor_type));
> > +	id =3D 0;
> > +	for (i =3D 0; i < sensor_num; i++) {
> > +		params->cmd =3D MOTIONSENSE_CMD_INFO;
> > +		params->info.sensor_num =3D i;
> > +		ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> > +		if (ret < 0 || msg->result !=3D EC_RES_SUCCESS) {
> > +			dev_warn(ec_dev->dev, "no info for EC sensor %d : %d/%d\n",
> > +				 i, ret, msg->result);
> > +			continue;
> > +		}
> > +		switch (resp->info.type) {
> > +		case MOTIONSENSE_TYPE_ACCEL:
> > +			sensor_cells[id].name =3D "cros-ec-accel";
> > +			break;
> > +		case MOTIONSENSE_TYPE_BARO:
> > +			sensor_cells[id].name =3D "cros-ec-baro";
> > +			break;
> > +		case MOTIONSENSE_TYPE_GYRO:
> > +			sensor_cells[id].name =3D "cros-ec-gyro";
> > +			break;
> > +		case MOTIONSENSE_TYPE_MAG:
> > +			sensor_cells[id].name =3D "cros-ec-mag";
> > +			break;
> > +		case MOTIONSENSE_TYPE_PROX:
> > +			sensor_cells[id].name =3D "cros-ec-prox";
> > +			break;
> > +		case MOTIONSENSE_TYPE_LIGHT:
> > +			sensor_cells[id].name =3D "cros-ec-light";
> > +			break;
> > +		case MOTIONSENSE_TYPE_ACTIVITY:
> > +			sensor_cells[id].name =3D "cros-ec-activity";
> > +			break;
> > +		default:
> > +			dev_warn(ec_dev->dev, "unknown type %d\n",
> > +				 resp->info.type);
> > +			continue;
> > +		}
> > +		sensor_platforms[id].sensor_num =3D i;
> > +		sensor_platforms[id].cmd_offset =3D ec_p.cmd_offset;
> > +		sensor_cells[id].id =3D sensor_type[resp->info.type];
> > +		sensor_cells[id].platform_data =3D &sensor_platforms[id];
> > +		sensor_cells[id].pdata_size =3D
> > +			sizeof(struct cros_ec_sensor_platform);
> > +
> > +		sensor_type[resp->info.type]++;
> > +		id++;
> > +	}
> > +	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >=3D 2) {
> > +		sensor_platforms[id].sensor_num =3D sensor_num;
> > +
> > +		sensor_cells[id].name =3D "cros-ec-angle";
> > +		sensor_cells[id].id =3D 0;
> > +		sensor_cells[id].platform_data =3D &sensor_platforms[id];
> > +		sensor_cells[id].pdata_size =3D
> > +			sizeof(struct cros_ec_sensor_platform);
> > +		id++;
> > +	}
> > +
> > +	ret =3D mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, sensor_cell=
s,
> > +			      id, NULL, 0, NULL);
> > +	if (ret)
> > +		dev_err(ec_dev->dev, "failed to add EC sensors\n");
> > +
> > +	kfree(sensor_platforms);
> > +error_platforms:
> > +	kfree(sensor_cells);
> > +error:
> > +	kfree(msg);
> > +}
> > +
> >  int cros_ec_register(struct cros_ec_device *ec_dev)
> >  {
> >  	struct device *dev =3D ec_dev->dev;
> > @@ -94,6 +248,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >  	ec_dev->max_request =3D sizeof(struct ec_params_hello);
> >  	ec_dev->max_response =3D sizeof(struct ec_response_get_protocol_info)=
;
> >  	ec_dev->max_passthru =3D 0;
> > +	ec_dev->features[0] =3D -1U; /* Not cached yet */
> > +	ec_dev->features[1] =3D -1U; /* Not cached yet */
> > =20
> >  	ec_dev->din =3D devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
> >  	if (!ec_dev->din)
> > @@ -127,6 +283,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev=
)
> >  		goto fail_mfd;
> >  	}
> > =20
> > +	/* Check whether this EC is a sensor hub. */
> > +	if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
> > +		cros_ec_sensors_register(ec_dev);
> > +
> >  	if (ec_dev->max_passthru) {
> >  		/*
> >  		 * Register a PD device as well on top of this device.
> > diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/c=
hrome/cros_ec_dev.c
> > index b9bf086..4947650 100644
> > --- a/drivers/platform/chrome/cros_ec_dev.c
> > +++ b/drivers/platform/chrome/cros_ec_dev.c
> > @@ -90,41 +90,6 @@ static int ec_get_version(struct cros_ec_dev *ec, ch=
ar *str, int maxlen)
> >  	return ret;
> >  }
> > =20
> > -static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> > -{
> > -	struct cros_ec_command *msg;
> > -	int ret;
> > -
> > -	if (ec->features[0] =3D=3D -1U && ec->features[1] =3D=3D -1U) {
> > -		/* features bitmap not read yet */
> > -
> > -		msg =3D kmalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> > -		if (!msg)
> > -			return -ENOMEM;
> > -
> > -		msg->version =3D 0;
> > -		msg->command =3D EC_CMD_GET_FEATURES + ec->cmd_offset;
> > -		msg->insize =3D sizeof(ec->features);
> > -		msg->outsize =3D 0;
> > -
> > -		ret =3D cros_ec_cmd_xfer(ec->ec_dev, msg);
> > -		if (ret < 0 || msg->result !=3D EC_RES_SUCCESS) {
> > -			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
> > -				 ret, msg->result);
> > -			memset(ec->features, 0, sizeof(ec->features));
> > -		}
> > -
> > -		memcpy(ec->features, msg->data, sizeof(ec->features));
> > -
> > -		dev_dbg(ec->dev, "EC features %08x %08x\n",
> > -			ec->features[0], ec->features[1]);
> > -
> > -		kfree(msg);
> > -	}
> > -
> > -	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> > -}
> > -
> >  /* Device file ops */
> >  static int ec_device_open(struct inode *inode, struct file *filp)
> >  {
> > @@ -268,126 +233,6 @@ static void __remove(struct device *dev)
> >  	kfree(ec);
> >  }
> > =20
> > -static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> > -{
> > -	/*
> > -	 * Issue a command to get the number of sensor reported.
> > -	 * Build an array of sensors driver and register them all.
> > -	 */
> > -	int ret, i, id, sensor_num;
> > -	struct mfd_cell *sensor_cells;
> > -	struct cros_ec_sensor_platform *sensor_platforms;
> > -	int sensor_type[MOTIONSENSE_TYPE_MAX];
> > -	struct ec_params_motion_sense *params;
> > -	struct ec_response_motion_sense *resp;
> > -	struct cros_ec_command *msg;
> > -
> > -	msg =3D kzalloc(sizeof(struct cros_ec_command) +
> > -		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> > -	if (msg =3D=3D NULL)
> > -		return;
> > -
> > -	msg->version =3D 2;
> > -	msg->command =3D EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> > -	msg->outsize =3D sizeof(*params);
> > -	msg->insize =3D sizeof(*resp);
> > -
> > -	params =3D (struct ec_params_motion_sense *)msg->data;
> > -	params->cmd =3D MOTIONSENSE_CMD_DUMP;
> > -
> > -	ret =3D cros_ec_cmd_xfer(ec->ec_dev, msg);
> > -	if (ret < 0 || msg->result !=3D EC_RES_SUCCESS) {
> > -		dev_warn(ec->dev, "cannot get EC sensor information: %d/%d\n",
> > -			 ret, msg->result);
> > -		goto error;
> > -	}
> > -
> > -	resp =3D (struct ec_response_motion_sense *)msg->data;
> > -	sensor_num =3D resp->dump.sensor_count;
> > -	/* Allocate 2 extra sensors in case lid angle or FIFO are needed */
> > -	sensor_cells =3D kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
> > -			       GFP_KERNEL);
> > -	if (sensor_cells =3D=3D NULL)
> > -		goto error;
> > -
> > -	sensor_platforms =3D kzalloc(sizeof(struct cros_ec_sensor_platform) *
> > -		  (sensor_num + 1), GFP_KERNEL);
> > -	if (sensor_platforms =3D=3D NULL)
> > -		goto error_platforms;
> > -
> > -	memset(sensor_type, 0, sizeof(sensor_type));
> > -	id =3D 0;
> > -	for (i =3D 0; i < sensor_num; i++) {
> > -		params->cmd =3D MOTIONSENSE_CMD_INFO;
> > -		params->info.sensor_num =3D i;
> > -		ret =3D cros_ec_cmd_xfer(ec->ec_dev, msg);
> > -		if (ret < 0 || msg->result !=3D EC_RES_SUCCESS) {
> > -			dev_warn(ec->dev, "no info for EC sensor %d : %d/%d\n",
> > -				 i, ret, msg->result);
> > -			continue;
> > -		}
> > -		switch (resp->info.type) {
> > -		case MOTIONSENSE_TYPE_ACCEL:
> > -			sensor_cells[id].name =3D "cros-ec-accel";
> > -			break;
> > -		case MOTIONSENSE_TYPE_BARO:
> > -			sensor_cells[id].name =3D "cros-ec-baro";
> > -			break;
> > -		case MOTIONSENSE_TYPE_GYRO:
> > -			sensor_cells[id].name =3D "cros-ec-gyro";
> > -			break;
> > -		case MOTIONSENSE_TYPE_MAG:
> > -			sensor_cells[id].name =3D "cros-ec-mag";
> > -			break;
> > -		case MOTIONSENSE_TYPE_PROX:
> > -			sensor_cells[id].name =3D "cros-ec-prox";
> > -			break;
> > -		case MOTIONSENSE_TYPE_LIGHT:
> > -			sensor_cells[id].name =3D "cros-ec-light";
> > -			break;
> > -		case MOTIONSENSE_TYPE_ACTIVITY:
> > -			sensor_cells[id].name =3D "cros-ec-activity";
> > -			break;
> > -		default:
> > -			dev_warn(ec->dev, "unknown type %d\n", resp->info.type);
> > -			continue;
> > -		}
> > -		sensor_platforms[id].sensor_num =3D i;
> > -		sensor_cells[id].id =3D sensor_type[resp->info.type];
> > -		sensor_cells[id].platform_data =3D &sensor_platforms[id];
> > -		sensor_cells[id].pdata_size =3D
> > -			sizeof(struct cros_ec_sensor_platform);
> > -
> > -		sensor_type[resp->info.type]++;
> > -		id++;
> > -	}
> > -	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >=3D 2) {
> > -		sensor_platforms[id].sensor_num =3D sensor_num;
> > -
> > -		sensor_cells[id].name =3D "cros-ec-angle";
> > -		sensor_cells[id].id =3D 0;
> > -		sensor_cells[id].platform_data =3D &sensor_platforms[id];
> > -		sensor_cells[id].pdata_size =3D
> > -			sizeof(struct cros_ec_sensor_platform);
> > -		id++;
> > -	}
> > -	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> > -		sensor_cells[id].name =3D "cros-ec-ring";
> > -		id++;
> > -	}
> > -
> > -	ret =3D mfd_add_devices(ec->dev, 0, sensor_cells, id,
> > -			      NULL, 0, NULL);
> > -	if (ret)
> > -		dev_err(ec->dev, "failed to add EC sensors\n");
> > -
> > -	kfree(sensor_platforms);
> > -error_platforms:
> > -	kfree(sensor_cells);
> > -error:
> > -	kfree(msg);
> > -}
> > -
> >  static int ec_device_probe(struct platform_device *pdev)
> >  {
> >  	int retval =3D -ENOMEM;
> > @@ -402,8 +247,6 @@ static int ec_device_probe(struct platform_device *=
pdev)
> >  	ec->ec_dev =3D dev_get_drvdata(dev->parent);
> >  	ec->dev =3D dev;
> >  	ec->cmd_offset =3D ec_platform->cmd_offset;
> > -	ec->features[0] =3D -1U; /* Not cached yet */
> > -	ec->features[1] =3D -1U; /* Not cached yet */
> >  	device_initialize(&ec->class_dev);
> >  	cdev_init(&ec->cdev, &fops);
> > =20
> > @@ -432,10 +275,6 @@ static int ec_device_probe(struct platform_device =
*pdev)
> >  	if (cros_ec_debugfs_init(ec))
> >  		dev_warn(dev, "failed to create debugfs directory\n");
> > =20
> > -	/* check whether this EC is a sensor hub. */
> > -	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
> > -		cros_ec_sensors_register(ec);
> > -
> >  	/* Take control of the lightbar from the EC. */
> >  	lb_manual_suspend_ctrl(ec, 1);
> > =20
> > diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> > index 3b16c90..8f87999 100644
> > --- a/include/linux/mfd/cros_ec.h
> > +++ b/include/linux/mfd/cros_ec.h
> > @@ -115,6 +115,7 @@ struct cros_ec_command {
> >   * @event_notifier: interrupt event notifier for transport devices.
> >   * @event_data: raw payload transferred with the MKBP event.
> >   * @event_size: size in bytes of the event data.
> > + * @features: stores the EC features.
> >   */
> >  struct cros_ec_device {
> > =20
> > @@ -149,15 +150,19 @@ struct cros_ec_device {
> > =20
> >  	struct ec_response_get_next_event event_data;
> >  	int event_size;
> > +	u32 features[2];
> >  };
> > =20
> >  /**
> >   * struct cros_ec_sensor_platform - ChromeOS EC sensor platform inform=
ation
> >   *
> >   * @sensor_num: Id of the sensor, as reported by the EC.
> > + * @cmd_offset: offset to apply for each command. Set when
> > + * registering a devicde behind another one.
> >   */
> >  struct cros_ec_sensor_platform {
> >  	u8 sensor_num;
> > +	u16 cmd_offset;
> >  };
> > =20
> >  /* struct cros_ec_platform - ChromeOS EC platform information
> > @@ -191,7 +196,6 @@ struct cros_ec_dev {
> >  	struct device *dev;
> >  	struct cros_ec_debugfs *debug_info;
> >  	u16 cmd_offset;
> > -	u32 features[2];
> >  };
> > =20
> >  /**
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
