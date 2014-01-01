
/*
 +------------------------------------------------------------------------+
 | Phalcon Framework                                                      |
 +------------------------------------------------------------------------+
 | Copyright (c) 2011-2013 Phalcon Team (http://www.phalconphp.com)       |
 +------------------------------------------------------------------------+
 | This source file is subject to the New BSD License that is bundled     |
 | with this package in the file docs/LICENSE.txt.                        |
 |                                                                        |
 | If you did not receive a copy of the license and are unable to         |
 | obtain it through the world-wide-web, please send an email             |
 | to license@phalconphp.com so we can send you a copy immediately.       |
 +------------------------------------------------------------------------+
 | Authors: Andres Gutierrez <andres@phalconphp.com>                      |
 |          Eduar Carvajal <eduar@phalconphp.com>                         |
 +------------------------------------------------------------------------+
 */

namespace Phalcon\Validation\Validator;

/**
 * Phalcon\Validation\Validator\Confirmation
 *
 * Checks that two values have the same value
 *
 *<code>
 *use Phalcon\Validation\Validator\Confirmation;
 *
 *$validator->add('password', new Confirmation(array(
 *   'message' => 'Password doesn\'t match confirmation',
 *   'with' => 'confirmPassword'
 *)));
 *</code>
 */
class Confirmation extends Phalcon\Validation\Validator implements Phalcon\Validation\ValidatorInterface
{

	/**
	 * Executes the validation
	 *
	 * @param Phalcon\Validation validation
	 * @param string field
	 * @return boolean
	 */
	public function validate(<Phalcon\Validation> validation, string field) -> boolean
	{
		var withAttribute, value, withValue, message, label, replacePairs;

		let withAttribute = this->getOption("with"),
			value = validation->getValue(field),
			withValue = validation->getValue(withAttribute);

		if value != withValue {

                        let label = this->getOption("label");
                        if empty label {
                                let label = field;
			}

			let message = this->getOption("message");
                        let replacePairs = [":field": label, ":with":  withAttribute];
			if empty message {
                                let message = validation->getDefaultMessage("Confirmation");
			}

			validation->appendMessage(new Phalcon\Validation\Message(strtr(message, replacePairs), field, "Confirmation"));
			return false;
		}

		return true;
	}
}