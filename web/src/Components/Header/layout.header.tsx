import { Col, Dropdown, MenuProps, Row, Select } from 'antd';
import React from 'react';
import './layout.header.scss';
import countryLogo from '../../Assets/Images/nigeria.png';
import { useTranslation } from 'react-i18next';
import { HeaderProps } from '../../Definitions/InterfacesAndType/layout.header';
import { PersonCircle } from 'react-bootstrap-icons';
import { useConnection } from '../../Context/ConnectionContext/connectionContext';
import { useUserContext } from '../../Context/UserInformationContext/userInformationContext';

const LayoutHeader = (props: HeaderProps) => {
  const { title } = props;
  const { updateToken } = useConnection();
  const { removeUserInfo } = useUserContext();
  const { i18n } = useTranslation(['common', 'login']);
  const handleLanguageChange = (lang: string) => {
    i18n.changeLanguage(lang);
  };

  const signOut = (): void => {
    updateToken();
    removeUserInfo();
  };

  const items: MenuProps['items'] = [
    {
      key: '1',
      label: <a onClick={() => signOut()}>Sign Out</a>,
    },
  ];

  return (
    <div className="header-container">
      <Row>
        <Col span={1} offset={23}>
          <Row>
            <Col>
              <div className="header-country-logo">
                <img src={countryLogo} alt="country-logo" />
              </div>
              {/* <div className="header-menu-container">
                <div className="header-signOut-container">
                  <Dropdown menu={{ items }} placement="bottomLeft">
                    <PersonCircle size={25} />
                  </Dropdown>
                </div>
              </div> */}
            </Col>
          </Row>
        </Col>
      </Row>
    </div>
  );
};

export default LayoutHeader;
